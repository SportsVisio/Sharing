import { jwtConstants } from './../auth/token/token.constants';
import { NotFoundException } from "@nestjs/common";

export const SwaggerHeaderDefaults = jwtConstants.headerOptions;

export const PromisedNotFoundException = (err) => {
  throw new NotFoundException(err);
};
