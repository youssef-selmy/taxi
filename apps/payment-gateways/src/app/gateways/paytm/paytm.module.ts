import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { PayTMController } from './paytm.controller';
import { PayTMService } from './paytm.service';

@Module({
  imports: [
    PaymentModule,
    HttpModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity])
  ],
  controllers: [PayTMController],
  providers: [PayTMService],
  exports: [PayTMService]
})
export class PayTMModule {}
