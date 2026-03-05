import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { BambooPayController } from './bamboopay.controller';
import { BambooPayService } from './bamboopay.service';

@Module({
  imports: [
    PaymentModule,
    HttpModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity]),
  ],
  controllers: [BambooPayController],
  providers: [BambooPayService],
  exports: [BambooPayService],
})
export class BambooPayModule {}
