import { INestApplication } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';

export const initSwagger = (app: INestApplication, url = "swagger"): void => {
  const options = new DocumentBuilder()
    .setTitle('SportsVisio Consumer API')
    .setDescription('RESTful api for the accessing stream data')
    .setVersion('1.0')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, options);
  
  SwaggerModule.setup(url, app, document);
};