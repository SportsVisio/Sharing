import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse } from '@nestjs/swagger';
import { Body, Controller, Post, UploadedFile, UseGuards, UseInterceptors, BadRequestException, Get, Param } from '@nestjs/common';
import { SwaggerHeaderDefaults } from './../common/constants';
import { FileInterceptor } from "@nestjs/platform-express";
import { AiWorkerInstanceData, GetAiWorkerInstanceDataParams, GetProcessVideoParams } from "./ai-workers.classes";
import { AiWorkerService } from "./ai-workers.service";
import { IAiWorkerInstanceData } from "./ai-workers.interfaces";

@Controller('ai-workers')
@ApiTags("AI Workers")
export class AiWorkersController {
  constructor(
    public workers: AiWorkerService
  ) { }
  
  @Get("process/:scheduledGameId")
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  public process(@Param() { scheduledGameId }: GetProcessVideoParams): Promise<IAiWorkerInstanceData> {
    return this.workers.start(scheduledGameId);
  }

  @Get("stop/:ec2InstanceId")
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  public stop(@Param() { ec2InstanceId }: GetAiWorkerInstanceDataParams): Promise<boolean> {
    return this.workers.stop(ec2InstanceId);
  }

  // down here because of route pattern match ordering
  @Get(":ec2InstanceId")
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: AiWorkerInstanceData, isArray: true })
  @ApiResponse({ status: 404, description: 'Instance not found.' })
  public getInstanceData(@Param() { ec2InstanceId }: GetAiWorkerInstanceDataParams): Promise<AiWorkerInstanceData> {
    return this.workers.get(ec2InstanceId);
  }
}