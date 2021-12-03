import { ApiProperty } from "@nestjs/swagger";

export enum UploadPrefixes {
  PROFILE = "profile",
  TEAM = "team"
}

export class UploadFileInput {
  @ApiProperty({
    description: "String prefix of file being created, for organizational purposes",
    enumName: "UploadPrefixes"
  })
  prefix: UploadPrefixes;
}