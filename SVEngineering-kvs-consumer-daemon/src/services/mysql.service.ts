import { Connection, ConnectionConfig, createConnection } from "mysql";

export class MySqlService {
  public connection: Connection;
  constructor(options: ConnectionConfig) {
    this.connection = createConnection(options);
    this.connection.connect();
  }
  public query<T>(sql: string, vars?: unknown): Promise<T> {
    return new Promise((resolve, reject) => {
      this.connection.query(sql, vars, (err, results) => {
        if (err) reject(err);
        else resolve(results);
      });
    });
  }
}