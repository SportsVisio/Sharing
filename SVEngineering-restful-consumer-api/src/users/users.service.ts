import { User } from './user.entity';
import { BadRequestException, Injectable, InternalServerErrorException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindManyOptions, Repository } from 'typeorm';
import { UserSignupInput, UserActivateInput, UserUpdateInput } from "./user.classes";
import { Account } from "../account/account.entity";
import { SendGridService } from "@anchan828/nest-sendgrid";
import { logger } from "../common/logger";
import { EmailTemplateFactory } from "../common/templates";
import { generate } from "generate-password";
import { PlayerProfile } from "../player-profile/player-profile.entity";
import { PromisedNotFoundException } from "../common/constants";

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    public user: Repository<User>,
    @InjectRepository(Account)
    public account: Repository<Account>,
    @InjectRepository(PlayerProfile)
    public profiles: Repository<PlayerProfile>,
    private sendGrid: SendGridService
  ) {}

  public async findByEmail(email: string): Promise<User> {
    return this.user.findOneOrFail({
      where: {
        email
      }
    }).catch(PromisedNotFoundException);
  }

  public async get(id: string, options?: Partial<FindManyOptions<User>>): Promise<User> {
    return this.user.findOneOrFail(id, options).catch(PromisedNotFoundException);
  }

  public signup(input: UserSignupInput): Promise<User> {
    const acct = new Account();
    acct.inactive = false;

    return this.user.create({
      ...input,
      account: this.account.create({
        inactive: false
      }),
      playerProfile: this.profiles.create()
    }).save().catch((err) => {
      // TODO - secure this with more obscure messaging / flow / ratelimit
      if (err.errno === 1062) throw new BadRequestException("Email address already in use");
      logger.error("User signup error");
      logger.error(err);

      throw err;
    });
  }

  public async recover(email: string): Promise<boolean> {
    const password = generate({
      length: 12,
      numbers: true,
      symbols: true
    });

    const user = await this.findByEmail(email);
    user.password = password;

    await user.save();

    const subject = "Account recovery request";

    const html = EmailTemplateFactory("forgot-password", {
      password
    }, subject);
    return this.sendGrid.send({
      to: email,
      from: process.env.SENDGRID_FROM_ADDRESS,
      subject,
      html,
    }).then(() => true);
  }

  // NOTE: for future use when email / token verification is needed
  public async activate(input: UserActivateInput): Promise<User> {
    const user = await this.user.findOne(input.signupToken);
    if (!user || !user.inactive) throw new BadRequestException();

    user.inactive = false;

    return user.save();
  }

  public async update(id: string, input: UserUpdateInput): Promise<User> {
    const user = await this.get(id);
    return Object.assign(user, input).save();
  }
}
