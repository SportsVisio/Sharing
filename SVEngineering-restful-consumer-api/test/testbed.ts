import { config } from "aws-sdk";

import { config as dotenv } from "dotenv";
import { getConnection } from "typeorm";
dotenv();

config.update({
  region: process.env.AWS_REGION || "us-east-1"
});

// different in the Jest runtime than the Serverless or NestJs runtime
export const TypeOrmEntityPattern = "src/**/*.entity.ts";

export const closeOpenHandles = (): Promise<void> => {
  
  try {
    const conn = getConnection();
    conn?.close();
  }
  catch (exc) {}

  return new Promise<void>(resolve => setTimeout(() => resolve(), 500)); // avoid jest open handle error
};