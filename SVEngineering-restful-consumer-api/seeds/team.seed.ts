import { User } from './../src/users/user.entity';
import { Factory, Seeder } from 'typeorm-seeding';
import { hasRun, recordRun } from "../src/common/seed.util";
import { Team } from "../src/teams/team.entity";

export default class CreateTeams implements Seeder {
  public run(factory: Factory): Promise<any> {
    return hasRun(__filename).then(async r => {
      if (r) return true;

      return Promise.all(
        (await User.find()).map(async user => {
          const { account: { id: accountId } } = user;
          return Promise.all([
            factory(Team)({ accountId }).create(),
            factory(Team)({ accountId }).create(),
          ]);
        })
      );
    }).then(() => recordRun(__filename));
  }
}