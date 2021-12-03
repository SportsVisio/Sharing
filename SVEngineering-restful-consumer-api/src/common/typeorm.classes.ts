import { BadRequestException } from '@nestjs/common';
import { ApiProperty } from '@nestjs/swagger';
import { BaseEntity, BeforeInsert, BeforeUpdate, Column, DeleteDateColumn, Index, PrimaryGeneratedColumn, SaveOptions, Unique } from 'typeorm';
import { validateOrReject } from 'class-validator';
import { classToPlain } from 'class-transformer';
import { TypeOrmModuleOptions } from "@nestjs/typeorm";
import { customAlphabet, nanoid } from 'nanoid';
import { DefaultNamingStrategy } from 'typeorm';

@Unique(["id"])
export class CustomBaseEntity extends BaseEntity {

  @PrimaryGeneratedColumn("uuid")
  @ApiProperty({
    type: "string",
    example: "7a5e7bf4-ad48-4a01-b64b-46f515de2c86"
  })
  id: string;

  @Column({
    type: "datetime",
    default: () => "CURRENT_TIMESTAMP"
  })
  @ApiProperty()
  createdAt: Date;

  @Column({
    type: "timestamp",
    nullable: true,
    default: () => "CURRENT_TIMESTAMP"
  })
  @ApiProperty()
  updatedAt: Date;

  @BeforeInsert()
  @BeforeUpdate()
  protected async insertValidate(): Promise<void> {
    try {
      await validateOrReject(this);
    }
    catch (exc) {      
      throw new BadRequestException(exc);
    }
  }

  @BeforeUpdate()
  protected updateValidate(): void {
    this.updatedAt = new Date();
  }

  // override this function so we can @Exclude columns
  public toJSON(): Record<string, any> {
    const plain = classToPlain(this);
    // rebuild (wtf typeorm??)
    return Object.keys(plain).reduce((prev, curr) => {
      // remove double underscore names for resolve lazy loaded relations. ugh.
      const k = curr.startsWith("__") ? curr.slice(2, -2) : curr;
      prev[k] = plain[curr];

      return prev;
    }, {} as any);
  }
}

export class SoftDeletableBaseEntity extends CustomBaseEntity {
  @DeleteDateColumn()
  deletedAt?: Date;

  // override delete to prevent accidental use
  public delete(options?: SaveOptions): Promise<this> {
    return this.softRemove(options);
  }

  public hardDelete(options?: SaveOptions): Promise<this> {
    return this.delete(options);
  }

  public recover(updates?: any): Promise<this> {
    this.deletedAt = null;
    if (updates) Object.keys(updates).forEach(k => this[k] = updates[k]);

    return this.save();
  }
}

export class DeactivateableBaseEntity extends CustomBaseEntity {
  @Column({
    default: false
  })
  @Index()
  @ApiProperty({
    description: "Active / Inactive status"
  })
  inactive: boolean;
}

// const ALIAS_LENGTH = 18;

export class NamingStrategy extends DefaultNamingStrategy {
  
  private _aliasCache: { [key: string]: string } = {};
  
  eagerJoinRelationAlias(alias: string, propertyPath: string): string {

    const key = `${alias}:${propertyPath}`;

    if (this._aliasCache[key]) return this._aliasCache[key];

    // NOTE: Leaving this commented out just in case this aliasing pattern causes an issue
    // console.log(`${key} -- ${this._aliasCache[key]}`);

    // const orig = super.eagerJoinRelationAlias(alias, propertyPath);
    // const characters = orig.replace(/_/g, '').toUpperCase();
    // const nanoid = customAlphabet(characters, ALIAS_LENGTH);
    const out = nanoid();

    this._aliasCache[key] = out;

    return out;
  }
}

// use a factory here so that the shared module, loaded first, will process local .env
export const TypeOrmConfigFactory = (entityPattern?: string): TypeOrmModuleOptions | any => {
  const {
    DB_USER: username = "root",
    DB_PASS: password = "root",
    DB_ENDPOINT: host = "0.0.0.0",
  } = process.env;

  return {
    type: "mysql",
    port: 3306,
    database: "sportsvisio",
    entities: [
      entityPattern || "{.build,dist}/**/*.entity.js"
    ],
    // synchronize: true,
    migrationsTableName: "_migrations",
    migrations: ["{.build,dist}/migrations/*.js"],
    migrationsRun: true,
    seeds: ['{.build,dist}/seeds/**/*.js'],
    factories: ['{.build,dist}/factories/**/*.js'],
    cli: {
      migrationsDir: "migrations"
    },
    keepConnectionAlive: true,
    host,
    username,
    password,
    logging: false,
    namingStrategy: new NamingStrategy()
  };
};
