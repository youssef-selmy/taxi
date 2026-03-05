import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { AmazonPaymentServicesController } from './amazon.controller';
import { AmazonPaymentServicesService } from './amazon.service';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity]),
  ],
  controllers: [AmazonPaymentServicesController],
  providers: [AmazonPaymentServicesService],
  exports: [AmazonPaymentServicesService],
})
export class AmazonPaymentServicesModule {}
