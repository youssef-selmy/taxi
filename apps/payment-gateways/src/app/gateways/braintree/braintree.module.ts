import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { BraintreeController } from './braintree.controller';
import { BraintreeService } from './braintree.service';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity]),
  ],
  controllers: [BraintreeController],
  providers: [BraintreeService],
  exports: [BraintreeService],
})
export class BraintreeModule {}
