import * as winston from "winston";
import * as WinstonCloudWatch from "winston-cloudwatch";

// export enum WinstonErrorLevels {
//   error = "error",
//   warn = "warn",
//   info = "info",
//   http = "http",
//   verbose = "verbose",
//   debug = "debug",
//   silly = "silly"
// }

winston.addColors({
  error: 'red',
  warn: 'yellow',
  info: 'cyan',
  debug: 'green'
});

// log to cloudwatch when deployed
if (process.env.NODE_ENV) {
  winston.add(new WinstonCloudWatch({
    name: `[${process.env.NODE_ENV}] Consumer Api`,
    logStreamName: "API"
  }));
}

export const logger = !process.env.NODE_ENV ? console : winston.createLogger({
  level: "info",
  format: winston.format.json(),
  // defaultMeta: { service: 'aps-api-service' },
  transports: [
    // - Write all logs with level `error` and below to `error.log`
    new winston.transports.File({ filename: "error.log", level: "error" }),
    // - Write all logs with level `info` and below to `combined.log`
    new winston.transports.File({ filename: "combined.log" }),
    // - Write all logs to console
    new winston.transports.Console({
      format: winston.format.combine(
        winston.format.timestamp({
          format: "MM-DD HH:mm:ss"
        }),
        winston.format.colorize(),
        winston.format.printf(({ level, timestamp, message }) => `${level} - [${timestamp}]:  ${JSON.stringify(message, null, 2)}`)
      )
    })
  ]
});