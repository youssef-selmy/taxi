import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { WayForPayController } from './way-for-pay.controller';
import { WayForPayService } from './way-for-pay.service';

@Module({
  imports: [
    PaymentModule,
    HttpModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity]),
  ],
  controllers: [WayForPayController],
  providers: [WayForPayService],
  exports: [WayForPayService],
})
export class WayForPayModule {}
