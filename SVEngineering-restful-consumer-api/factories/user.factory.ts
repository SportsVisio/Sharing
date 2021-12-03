import { User } from './../src/users/user.entity';
import Faker from 'faker';
import { define } from 'typeorm-seeding';
import { Account } from "../src/account/account.entity";

define(User, (faker: typeof Faker, context: User) => {
  return User.create({
    ...context,
    account: Account.create({
      inactive: false
    })
  });
});
