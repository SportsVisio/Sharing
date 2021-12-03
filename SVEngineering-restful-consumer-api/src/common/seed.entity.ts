import { Entity, Column, PrimaryColumn, BaseEntity } from 'typeorm';

@Entity()
export class Seed extends BaseEntity {
  @Column()
  @PrimaryColumn()
  file: string;
}