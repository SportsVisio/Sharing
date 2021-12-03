import { Annotation } from './../annotations/annotation.entity';
import { Account } from '../account/account.entity';
import { Court } from '../arenas/court.entity';
import { Entity, Column, OneToOne, JoinColumn, OneToMany, ManyToOne } from 'typeorm';
import { IsDefined } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { CustomBaseEntity } from "../common/typeorm.classes";
import { League } from "../leagues/league.entity";
import { TeamScheduledGameAssn } from "./scheduled-game-team-assn.entity";
import { DeviceScheduledGameAssn } from "../device/device-game-assn.entity";

@Entity()
export class ScheduledGame extends CustomBaseEntity {
  @Column({
    nullable: false
  })
  @ApiProperty({
    description: "Unix timestamp representing start of video capture timeframe",
    example: 1631216366
  })
  startTime: number;

  @Column({
    nullable: false
  })
  @ApiProperty({
    description: "Unix timestamp representing end of video capture timeframe",
    example: 1631216366
  })
  endTime: number;

  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Optional game description to use instead of TeamA / TeamB designation names",
    example: "Jags vs Rockets Showdown"
  })
  description: string;

  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Season this game applies to",
    example: "Fall 2022"
  })
  season: string;

  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Url to fully processed video from all angles"
  })
  processedVideoUrl: string;

  @ApiProperty({
    description: "League this game is scheduled to play in",
    type: () => League
  })
  @ManyToOne(() => League)
  @JoinColumn()
  league!: League;

  @ApiProperty({
    description: "Arena Court where this game is taking place",
    type: () => Court
  })
  @ManyToOne(() => Court)
  @JoinColumn()
  court!: Court;

  @ApiProperty({ 
    description: "Array of Team assignments to this game",
    type: () => TeamScheduledGameAssn, 
    isArray: true 
  })
  @OneToMany(() => TeamScheduledGameAssn, assn => assn.game, { cascade: true, eager: true })
  teamGameAssn: TeamScheduledGameAssn[];

  @ApiProperty({ 
    description: "Array of Device assignments to this game",
    type: () => DeviceScheduledGameAssn, 
    isArray: true 
  })
  @OneToMany(() => DeviceScheduledGameAssn, assn => assn.game, { eager: true })
  deviceGameAssn: DeviceScheduledGameAssn[];

  @ApiProperty({ 
    description: "Account this game belongs to",
    type: () => Account 
  })
  @ManyToOne(() => Account, acct => acct.scheduledGames)
  @JoinColumn()
  account: Account;

  @ApiProperty({ type: () => Annotation, isArray: true })
  @OneToMany(() => Annotation, annotation => annotation.scheduledGame, { eager: false })
  annotations: Annotation[];
}