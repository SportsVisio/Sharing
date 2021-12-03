import { BadRequestException } from '@nestjs/common';
export function EnumContains<T>(enumerable: T, search: string): boolean {
  return Object.values(enumerable).includes(search);
}

export function PromisedBadRequestException(error: unknown): void {
  throw new BadRequestException(error);
}

export function UnixTimestamp(date?: Date): number {
  return Math.floor((date?.getTime() || Date.now()) / 1000);
}