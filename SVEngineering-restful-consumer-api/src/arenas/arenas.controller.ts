import { GetArenaParams, CreateArenaPayload, UpdateArenaPayload, UpdateArenaParams, CreateArenaCourtPayload, CreateArenaCourtParams, UpdateArenaCourtPayload, UpdateArenaCourtParams } from './arena.classes';
import { Arena } from './arena.entity';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Delete, Request, Put } from '@nestjs/common';
import { IAuthenticatedRequest } from "../auth/auth.classes";
import { ArenaService } from "./arenas.service";

@Controller('arenas')
@ApiTags("Arenas")
export class ArenasController {
  constructor(
    public arenas: ArenaService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get("list")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: Arena, isArray: true })
  public getArenas(@Request() { user }: IAuthenticatedRequest): Promise<Arena[]> {
    return this.arenas.list();
  }

  @UseGuards(JwtAuthGuard)
  @Get(":arenaId")
  @ApiBearerAuth()
  @ApiResponse({ status: 200, description: 'Success.', type: Arena })
  @ApiResponse({ status: 404, description: 'Arena not found.' })
  public getArena(@Param() { arenaId }: GetArenaParams): Promise<Arena> {
    // TODO - permissions
    return this.arenas.get(arenaId);
  }

  @UseGuards(JwtAuthGuard)
  @Post("")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => CreateArenaPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Arena })
  public createArena(@Body() payload: CreateArenaPayload, @Request() { user }: IAuthenticatedRequest): Promise<Arena> {
    // TODO - permissions
    return this.arenas.create(payload);
  }

  @UseGuards(JwtAuthGuard)
  @Put(":arenaId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => UpdateArenaPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public updateArena(@Param() { arenaId }: UpdateArenaParams, @Body() payload: UpdateArenaPayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - permissions check
    return this.arenas.update(arenaId, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Post("courts/:arenaId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => CreateArenaCourtPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public createCourt(@Param() { arenaId }: CreateArenaCourtParams, @Body() payload: CreateArenaCourtPayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - check permissions
    return this.arenas.createCourt(arenaId, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Put("courts/:courtId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => UpdateArenaCourtPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public updateCourt(@Param() { courtId }: UpdateArenaCourtParams, @Body() payload: UpdateArenaCourtPayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - check permissions
    return this.arenas.updateCourt(courtId, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(":arenaId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: Arena })
  @ApiResponse({ status: 404, description: 'League not found.' })
  public deleteArena(@Param() { arenaId }: GetArenaParams): Promise<boolean> {
    // TODO - permissions
    return this.arenas.delete(arenaId);
  }

  @UseGuards(JwtAuthGuard)
  @Delete("courts/:courtId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: Arena })
  @ApiResponse({ status: 404, description: 'League not found.' })
  public deleteCourt(@Param() { courtId }: UpdateArenaCourtParams): Promise<boolean> {
    // TODO - permissions
    return this.arenas.deleteCourt(courtId);
  }

}
