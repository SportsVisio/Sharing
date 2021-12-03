import { MySqlService } from './mysql.service';
import { logger } from './../logger';
import { IAiWorkerInstanceData } from "../interfaces/ai-workers.interfaces";
import { EC2 } from "aws-sdk";

export class AiWorkerService extends MySqlService {
  private ec2Client: EC2 = null;

  public get amiId(): string {
    return process.env.AI_WORKER_AMI || "ami-087c17d1fe0178315";
  }

  constructor() {
    super({
      host: process.env.GLOBAL_DB_ENDPOINT || "0.0.0.0",
      user: process.env.GLOBAL_DB_USER || "",
      password: process.env.GLOBAL_DB_PASS || "",
      database: "global_ai_workers"
    });

    this.ec2Client = new EC2({ apiVersion: '2016-11-15' });
  }

  public list(): Promise<IAiWorkerInstanceData[]> {
    return this.query<IAiWorkerInstanceData[]>("SELECT * FROM ec2_workers", null);
  }

  public async get(instanceId: string): Promise<IAiWorkerInstanceData> {
    const result = await this.query<IAiWorkerInstanceData[]>("SELECT * FROM ec2_workers where instanceId = ?", [instanceId]);
    if (!result.length) throw new Error("No worker data found matching instanceId");

    return result[0];
  }

  public delete(instanceId: string): Promise<boolean> {
    return this.query("DELETE from ec2_workers where instanceId = ?", [instanceId]);
  }

}
