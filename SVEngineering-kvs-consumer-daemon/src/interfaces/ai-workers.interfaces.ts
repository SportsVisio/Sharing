export interface IAiWorkerInstanceData {
  instanceId: string;
  lastAction: number;
  idle: boolean;
  terminating: boolean;
  fileKey: string;
}