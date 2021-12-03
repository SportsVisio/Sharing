import { logger } from '../common/logger';
import { DynamoDB } from "aws-sdk";
import { v1 as uuidv1 } from "uuid";
import { DeleteItemInput, DocumentClient, GetItemInput, Key, QueryInput, UpdateItemInput } from "aws-sdk/clients/dynamodb";
import { Injectable } from "@nestjs/common";

@Injectable()
export class DynamoService {
  public dynamodb = new DynamoDB();

  public addRecord<T>(tableName: string, item: T): Promise<void> {
    logger.info(`Adding record to ${tableName}`);

    return new DocumentClient().put({
      TableName: tableName,
      Item: {
        uuid: uuidv1(),
        ...item
      }
    }).promise().then(() => {
      logger.info("Done.");
      return void 0;
    }).catch(err => {
      logger.error("Error writing record");
      logger.error(err);
      return void 0;
    });
  }
  
  public query<T>(tableName: string, params?: Partial<QueryInput>): Promise<T[]> {
    return new DocumentClient().query({
      TableName: tableName,
      ...params
    }).promise().then(({ Items }) => Items.map(i => i as T));
  }

  public getItem<T>(tableName: string, key: Key | any, params?: Partial<GetItemInput>): Promise<T> {
    return new DocumentClient().get({
      TableName: tableName,
      Key: key,
      ...params
    }).promise().then(({ Item }) => Item as T);
  }

  public updateItem(tableName: string, key: Key | any, params?: Partial<UpdateItemInput | any>): Promise<boolean> {
    return new DocumentClient().update({
      TableName: tableName,
      Key: key,
      ...params
    }).promise().then(() => true);
  }

  public delete(tableName: string, key: Key | any, params?: Partial<DeleteItemInput>): Promise<boolean> {
    return new DocumentClient().delete({
      TableName: tableName,
      Key: key,
      ...params
    }).promise().then(() => true).catch(err => {
      logger.error("Error deleting record");
      logger.error(err);
      return false;
    });
  }
}