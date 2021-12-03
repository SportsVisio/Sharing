import { Device } from './device.entity';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Delete, Request, Put } from '@nestjs/common';
import { DevicesService } from "./device.service";
import { AttachDeviceScheduledGamePayload, DeviceStreamActionParams, GetDeviceParams, GetDevicesParams, RegisterDevicePayload, UnregisterDeviceParams, UpdateDeviceScheduledGameParams, UpdateDeviceScheduledGamePayload } from "./device.classes";
import { IAuthenticatedRequest } from "../auth/auth.classes";

@Controller('devices')
@ApiTags("Devices")
export class DevicesController {
  constructor(
    public devices: DevicesService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get("list/:accountId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: Device, isArray: true })
  public list(@Param() { accountId }: GetDevicesParams, @Request() { user }: IAuthenticatedRequest): Promise<Device[]> {
    // TODO - check permissions if specifying accountId
    return this.devices.list(accountId || user.account.id);
  }

  @UseGuards(JwtAuthGuard)
  @Post("register")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: Device })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  @ApiBody({ type: () => RegisterDevicePayload })
  public register(@Body() { deviceId, name, accountId }: RegisterDevicePayload, @Request() { user }: IAuthenticatedRequest): Promise<Device> {
    // TODO - check permissions if specifying accountId
    return this.devices.create(deviceId, name, accountId || user.account.id);
  }

  @UseGuards(JwtAuthGuard)
  @Delete("unregister/:id")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: String })
  @ApiResponse({ status: 404, description: 'Device not found' })
  public unregister(@Param() { id }: UnregisterDeviceParams): Promise<boolean> {
    // TODO: permission check
    return this.devices.delete(id);
  }

  @UseGuards(JwtAuthGuard)
  @Post("attach")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: String })
  @ApiResponse({ status: 404, description: 'Assignment not found' })
  @ApiBody({ type: () => AttachDeviceScheduledGamePayload })
  public attach(@Body() payload: AttachDeviceScheduledGamePayload): Promise<boolean> {
    // TODO: permission check
    return this.devices.attachScheduledGame(payload);
  }

  @UseGuards(JwtAuthGuard)
  @Put("update-attachment/:assnId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: String })
  @ApiResponse({ status: 404, description: 'Assignment not found' })
  @ApiBody({ type: () => UpdateDeviceScheduledGamePayload })
  public updateAttachment(@Param() { id }: UpdateDeviceScheduledGameParams, @Body() payload: UpdateDeviceScheduledGamePayload): Promise<boolean> {
    // TODO: permission check
    return this.devices.updateGameAttachment(id, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Get("stream/start/:id")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: String })
  @ApiResponse({ status: 404, description: 'Not found' })
  public startStream(@Param() { id }: DeviceStreamActionParams): Promise<boolean> {
    // TODO - verify Cognito identify access to stream
    return this.devices.startStream(id);
  }

  @UseGuards(JwtAuthGuard)
  @Get("stream/stop/:id")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: String })
  @ApiResponse({ status: 404, description: 'Not found.' })
  public stopStream(@Param() { id }: DeviceStreamActionParams): Promise<boolean> {
    // TODO - verify Cognito identify access to stream
    return this.devices.stopStream(id);
  }

  // At the bottom because of route matching patterns
  @UseGuards(JwtAuthGuard)
  @Get(":deviceId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: Device, isArray: true })
  public get(@Param() { deviceId }: GetDeviceParams, @Request() { user }: IAuthenticatedRequest): Promise<Device> {
    // TODO - check permissions
    return this.devices.get(deviceId);
  }
}
