import { MySqlService } from './mysql.service';

export class SportsVisioService extends MySqlService {
  constructor() {
    super({
      host: process.env.DB_ENDPOINT,
      user: process.env.DB_USER,
      password: process.env.DB_PASS,
      database: 'sportsvisio'
    });
  }
}