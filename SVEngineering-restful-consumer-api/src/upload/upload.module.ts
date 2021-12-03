import { UploadsController } from './upload.controller';
import { Module } from '@nestjs/common';
import { SharedModule } from '../shared/shared.module';
import { UploadService } from "./upload.service";

@Module({
  imports: [
    SharedModule
  ],
  providers: [
    UploadService
  ],
  exports: [
    UploadService
  ],
  controllers: [
    UploadsController
  ]
})
export class UploadModule { }
