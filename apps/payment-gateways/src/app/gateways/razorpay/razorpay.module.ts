import { Module } from '@nestjs/common';
import { RazorPayService } from './razorpay.service';
import { RazorPayController } from './razorpay.controller';
import { PaymentModule } from '../../payment/payment.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([PaymentGatewayEntity])
  ],
  providers: [RazorPayService],
  exports: [RazorPayService],
  controllers: [RazorPayController]
})
export class RazorPayModule {}
