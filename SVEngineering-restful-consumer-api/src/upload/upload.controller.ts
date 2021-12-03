import { UploadService } from './upload.service';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { ApiTags, ApiBearerAuth, ApiHeader } from '@nestjs/swagger';
import { Body, Controller, Post, UploadedFile, UseGuards, UseInterceptors, BadRequestException } from '@nestjs/common';
import { SwaggerHeaderDefaults } from './../common/constants';
import { FileInterceptor } from "@nestjs/platform-express";
import { UploadFileInput } from "./upload.classes";

@Controller('upload')
@ApiTags("Uploads")
export class UploadsController {
  constructor(
    public uploads: UploadService
  ) { }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @UseInterceptors(FileInterceptor('file'))
  public uploadFile(@Body() { prefix }: UploadFileInput, @UploadedFile() file: Express.Multer.File): Promise<string> {
    return this.uploads.upload(prefix, file);
  }
}