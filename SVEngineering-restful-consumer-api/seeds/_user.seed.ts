import { User } from '../src/users/user.entity';
import { Factory, Seeder } from 'typeorm-seeding';
import { hasRun, recordRun } from "../src/common/seed.util";
import { League } from "../src/leagues/league.entity";
import * as faker from "faker";

export default class CreateUsers implements Seeder {
  public run(factory: Factory): Promise<any> {
    return hasRun(__filename).then(r => {
      if (r) return true;
      return Promise.all([
        factory(User)({ email: "machine-user@sportsvisio.com", firstName: 'Machine', lastName: 'User', password: "thisverylongpasswordisactuallyquitesecure" }).create(),
        factory(User)({ email: "scott@sportsvisio.com", firstName: 'Scott', lastName: 'Byers', password: "welcome12345" }).create(),
        factory(User)({ email: "brian@sportsvisio.com", firstName: 'Brian', lastName: 'French', password: "welcome12345" }).create(),
        factory(User)({ email: "elias@sportsvisio.com", firstName: 'Elias', lastName: 'Martin', password: "welcome12345" }).create(),
        factory(User)({ email: "vishal@sportsvisio.com", firstName: 'Vishal', lastName: 'Batvia', password: "welcome12345" }).create(),
        factory(User)({ email: "keeano@sportsvisio.com", firstName: 'Keeano', lastName: 'Martin', password: "welcome12345" }).create()
      ]).then(() => recordRun(__filename));
    });
  }
}