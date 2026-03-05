import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app/app.module';

import './instrument';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const port = parseInt(process.env.GATEWAY_API_PORT || '3333', 10);
  app.enableCors();
  app.enableShutdownHooks();
  await app.listen(port, () => {
    Logger.log(
      'Payment API Listening at http://localhost:' + port,
      'Payment Gateway API',
    );
  });
}

bootstrap();
