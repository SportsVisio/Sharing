import { config as dotenv } from "dotenv";
import { config } from "aws-sdk";

dotenv();

config.update({
  region: process.env.AWS_REGION || "us-east-1"
});