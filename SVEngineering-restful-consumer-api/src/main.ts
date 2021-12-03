import { NestFactory } from '@nestjs/core';
import { execSync } from "child_process";
import { AppModule } from './app.module';
import { HttpExceptionFilter } from "./http-exception.filter";
import { initSwagger } from "./swagger";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalFilters(new HttpExceptionFilter());

  initSwagger(app);

  await app.listen(3000).then(() => {
    if (process.env.NODE_ENV !== "prod") {
      // note: using odd root pattern here to overcome path issues with TypeOrm CLI when built / deployed with Dockerfile
      execSync(`npm run seed:run -- --root ${__dirname}/..`, { stdio: "inherit" });
    }
  });
}
bootstrap();
