import { Module } from '@nestjs/common';
import { PayUMoneyService } from './payumoney.service';
import { PayUMoneyController } from './payumoney.controller';
import { PaymentModule } from '../../payment/payment.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([PaymentGatewayEntity])
  ],
  providers: [PayUMoneyService],
  exports: [PayUMoneyService],
  controllers: [PayUMoneyController]
})
export class PayUMoneyModule {}
