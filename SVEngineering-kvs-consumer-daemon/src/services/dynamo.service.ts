import { logger } from '../logger';
import { DynamoDB } from "aws-sdk";
import { v1 as uuidv1 } from "uuid";
import { DeleteItemInput, DocumentClient, GetItemInput, Key, QueryInput, UpdateItemInput } from "aws-sdk/clients/dynamodb";

export const CheckpointTable = process.env.DYNAMO_CHECKPOINT_TABLE || "KinesisCheckpointing";

export class DynamoService {
  public dynamodb = new DynamoDB();

  public addRecord<T>(tableName: string, item: T): Promise<boolean> {
    logger.info(`Adding record to ${tableName}`);

    return new DocumentClient().put({
      TableName: tableName,
      Item: {
        uuid: uuidv1(),
        ...item
      }
    }).promise().then(() => {
      logger.info("Done.");
      return true;
    }).catch(err => {
      logger.error("Error writing fragment");
      logger.error(err);
      return false;
    });
  }

  // note: need to | any these inputs because DYNAMO IS THE ABSOLUTE FUCKING WORST
  public query<T>(tableName: string, params?: Partial<QueryInput | any>): Promise<T[]> {
    return new DocumentClient().query({
      TableName: tableName,
      ...params
    }).promise().then(({ Items }) => Items.map(i => i as T));
  }

  public getItem<T>(tableName: string, key: Key | any, params?: Partial<GetItemInput> | any): Promise<T> {
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

  public delete(tableName: string, key: Key | any, params?: Partial<DeleteItemInput | any>): Promise<boolean> {
    console.log({
      TableName: tableName,
      Key: key,
      ...params
    });
    return new DocumentClient().delete({
      TableName: tableName,
      Key: key,
      ...params
    }).promise().then(() => {
      console.log("the fuck");
      return true;
    }).catch(err => {
      logger.error("Error deleting record");
      logger.error(err);
      return false;
    });
  }
}