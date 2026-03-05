import { Module } from '@nestjs/common';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CryptoModule } from './crypto/crypto.module';
import { PaymentModule } from './payment/payment.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { GatewaysModule } from './gateways/gateways.module';
import { DataSourceOptions, createConnection } from 'typeorm';
import { PaymentGatewayEntity } from './database/payment-gateway.entity';
import { HttpModule } from '@nestjs/axios';
import { SavedPaymentMethodEntity } from './database/saved-payment-method.entity';
import { GatewayToUserEntity } from './database/gateway-to-user.entity';
import { PayoutMethodEntity } from './database/payout-method.entity';
import { APP_FILTER } from '@nestjs/core';
import { SentryGlobalFilter, SentryModule } from '@sentry/nestjs/setup';
import { entities } from '@ridy/database';
import { PaymentEntity } from './database/payment.entity';

@Module({
  imports: [
    CryptoModule,
    PaymentModule,
    HttpModule,
    SentryModule.forRoot(),
    TypeOrmModule.forFeature(entities),
    TypeOrmModule.forRootAsync({
      useFactory: async () => {
        const baseConn: DataSourceOptions = {
          type: 'mysql',
          host: process.env.MYSQL_HOST || 'localhost',
          port: 3306,
          username: process.env.MYSQL_USER || 'root',
          password: process.env.MYSQL_PASS || 'defaultpassword',
        };
        const conn = await createConnection({ ...baseConn, name: 'ts' });
        await conn.query(
          `CREATE DATABASE IF NOT EXISTS ${process.env.MYSQL_DB || 'waves'}`,
        );
        return {
          ...baseConn,
          database: process.env.MYSQL_DB || 'waves',
          autoLoadEntities: true,
          // legacySpatialSupport: false,
          //synchronize: true,
          // migrationsRun: true,
          logging: true,
        };
      },
    }),
    TypeOrmModule.forFeature([
      PaymentGatewayEntity,
      SavedPaymentMethodEntity,
      GatewayToUserEntity,
      PayoutMethodEntity,
      PaymentEntity,
    ]),
    ConfigModule.forRoot({
      cache: true,
      isGlobal: true,
    }),
    GatewaysModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_FILTER,
      useClass: SentryGlobalFilter,
    },
  ],
})
export class AppModule {}
