import { DeviceFragmentDetail } from "./ai-workers.classes";

export interface IAiWorkerInstanceData {
  instanceId: string;
  lastAction: number;
  idle: boolean;
  terminating: boolean;
  scheduledGameId: string;
  deviceVideoData: DeviceFragmentDetail[];
}