import Faker from 'faker';
import { define } from 'typeorm-seeding';
import { Team } from "../src/teams/team.entity";

define(Team, (faker: typeof Faker, { accountId }: { accountId: string }) => {
  return Team.create({
    account: {
      id: accountId
    },
    name: `${faker.lorem.words(2)} Team`
  });
});
