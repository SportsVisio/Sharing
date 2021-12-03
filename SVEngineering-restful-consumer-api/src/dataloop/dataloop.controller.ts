import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { DataloopService } from './dataloop.service';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiConsumes } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Delete, Res } from '@nestjs/common';
import { DownloadAnnotationsParams } from "./dataloop.classes";
import { firstValueFrom } from "rxjs";
import { Response } from "express";

@Controller('dataloop')
@ApiTags("Dataloop")
export class DataloopController {
  constructor(
    public Dataloop: DataloopService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get("annotations/:datasetId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: Object })
  @ApiResponse({ status: 403, description: 'Dataset not found.' })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public async annotations(@Param() { datasetId }: DownloadAnnotationsParams, @Res() res: Response): Promise<void> {
    res.set("Content-Type", "application/json");
    res.set("Content-Disposition", `attachment; filename=${datasetId}_annotations.zip`);
    res.end(
      await firstValueFrom(this.Dataloop.downloadAnnotations(datasetId))
    );
  }
}
