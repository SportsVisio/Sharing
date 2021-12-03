import { logger } from './../common/logger';
import { Injectable, BadRequestException } from '@nestjs/common';
import * as filestack from "filestack-js";
import { UploadPrefixes } from "./upload.classes";
import { EnumContains } from "../common/utilities";

@Injectable()
export class UploadService {
  private _client: filestack.Client;
  constructor() {
    this._client = filestack.init(process.env.FILESTACK_PUBLIC_KEY || "1");
  }

  public upload(prefix: UploadPrefixes, file: Express.Multer.File): Promise<string> {
    try {
      if (!prefix) throw new Error("No prefix specified.");
      if (!EnumContains(UploadPrefixes, prefix)) throw new Error("Invalid prefix specified");

      const extension = file.originalname.split(".").pop();

      return this._client.upload(file.buffer, {}, {
        filename: `${prefix}_${Date.now()}.${extension}`
      }).then(({ url }) => url);
    }
    catch (exc) {
      logger.error("Error uploading file");
      logger.error(exc);

      throw new BadRequestException(exc.message);
    }
  }
}
