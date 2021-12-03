import { Seed } from "./seed.entity";

export const hasRun = (file: string): Promise<boolean> => {
  return Seed.findOne(file).then(r => !!r).catch(() => false);
};

export const recordRun = (file: string): Promise<boolean> => {
  return Seed.create({ file }).save().then(() => true).catch(() => false);
};