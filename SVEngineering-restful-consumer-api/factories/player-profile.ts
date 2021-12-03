import Faker from 'faker';
import { define } from 'typeorm-seeding';
import { PlayerProfile } from "../src/player-profile/player-profile.entity";

define(PlayerProfile, (faker: typeof Faker, { userId }: { userId: string }) => {
  return PlayerProfile.create({
    user: {
      id: userId
    }
  });
});
