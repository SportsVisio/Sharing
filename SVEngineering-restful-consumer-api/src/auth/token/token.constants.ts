export const jwtConstants = {
  secret: process.env.TOKEN_SECRET_KEY || 'secretKey',
  // TODO - change 1y below to something more reasonable
  expiration: process.env.TOKEN_EXPIRATION || '1y',
  headerOptions: {
    name: 'Authorization',
    schema: {
      type: "string",
      example: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJIYWkhIiwiaWF0IjoxNTg5OTk4MjA3fQ"
    },
    description: 'Session token for current user',
  }
};