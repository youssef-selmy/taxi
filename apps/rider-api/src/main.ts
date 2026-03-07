import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import * as express from 'express';
import { RiderAPIModule } from './app/rider-api.module';
import { credential } from 'firebase-admin';
import { initializeApp } from 'firebase-admin/app';
import { loadSecrets } from '@ridy/database';

import './instrument';
import { getConfig } from 'license-verify';

async function bootstrap() {
  await loadSecrets();
  const app = await NestFactory.create(await RiderAPIModule.register());

  // Increase body size limit to 20MB
  app.use(express.json({ limit: '20mb' }));
  app.use(express.urlencoded({ limit: '20mb', extended: true }));

  const port = parseInt(process.env.RIDER_API_PORT || '3000', 10);
  app.enableShutdownHooks();
  app.enableCors();
  const config = await getConfig(process.env.NODE_ENV ?? 'production');
  if (config) {
    initializeApp({
      credential: credential.cert(
        `${process.cwd()}/config/${config.firebaseProjectPrivateKey}`,
      ),
    });
  }

  await app.listen(port, '0.0.0.0', () => {
    Logger.log('Listening at http://localhost:' + port, 'Rider API');
  });
}

bootstrap().catch((error) => {
  Logger.error(error, 'Rider API bootstrap');
  process.exit(1);
});
