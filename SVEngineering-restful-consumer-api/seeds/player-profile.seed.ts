import { User } from './../src/users/user.entity';
import { Factory, Seeder } from 'typeorm-seeding';
import { hasRun, recordRun } from "../src/common/seed.util";
import { PlayerProfile } from "../src/player-profile/player-profile.entity";

export default class CreatePlayerProfiles implements Seeder {
  public run(factory: Factory): Promise<any> {
    return hasRun(__filename).then(async r => {
      if (r) return true;

      return Promise.all(
        (await User.find()).map(async ({ id: userId }) => {
          return factory(PlayerProfile)({ userId }).create();
        })
      );
    }).then(() => recordRun(__filename));
  }
}