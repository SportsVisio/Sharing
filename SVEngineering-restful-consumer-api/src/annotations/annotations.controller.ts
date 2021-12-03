import { AnnotationActor } from './annotation-actor.entity';
import { PlayerProfileService } from './../player-profile/player-profile.service';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { PromisedNotFoundException, SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Delete, Request, Put } from '@nestjs/common';
import { IAuthenticatedRequest } from "../auth/auth.classes";
import { AnnotationService } from "./annotations.service";
import { AnnotationActionOutput, GetAnnotationsParams, ImportAnnotationParams, ImportAnnotationPayload } from "./annotations.classes";

@Controller('annotations')
@ApiTags("Annotations")
export class AnnotationsController {
  constructor(
    public annotations: AnnotationService,
    public profiles: PlayerProfileService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get(":profileId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: AnnotationActionOutput, isArray: true })
  @ApiResponse({ status: 404, description: 'Profile not found.' })
  public get(@Param() { profileId }: GetAnnotationsParams, @Request() { user }: IAuthenticatedRequest): Promise<AnnotationActionOutput[]> {
    // TODO - permissions
    return this.profiles.profiles.findOneOrFail(profileId || user.playerProfile.id, {
      relations: [
        "teamPlayerAssn", 
        "teamPlayerAssn.player", 
        "teamPlayerAssn.player.annotationActors", 
        "teamPlayerAssn.player.annotationActors.annotation"
      ]
    }).catch(PromisedNotFoundException).then(({ teamPlayerAssn }) => {
      const actors = teamPlayerAssn.reduce((prev, curr) => {
        prev.push(...curr.player.annotationActors);
        return prev;
      }, [] as AnnotationActor[]);

      return actors.reduce((prev, { actions, annotation }) => {
        delete annotation.actors;
        delete annotation.actions;

        prev.push(...actions.map(a => {
          a.annotation = annotation;          
          return a;
        }));
        return prev;
      }, [] as AnnotationActionOutput[]);
    });
  }

  @UseGuards(JwtAuthGuard)
  @Post("import/:scheduledGameId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: Boolean })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  @ApiBody({ type: () => ImportAnnotationPayload })
  public import(@Param() { scheduledGameId }: ImportAnnotationParams, @Body() { source, payload }: ImportAnnotationPayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - check permissions if specifying accountId
    return this.annotations.import(scheduledGameId, source, payload);
  }

  // @Get("sync")
  // @ApiResponse({ status: 200, description: 'Success', type: Boolean })
  // public sync(): Promise<boolean> {
  //   // TODO - check permissions if specifying accountId
  //   return this.annotations.sync();
  // }
}
