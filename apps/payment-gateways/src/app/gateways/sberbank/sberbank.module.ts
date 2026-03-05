import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { SberBankController } from './sberbank.controller';
import { SberBankService } from './sberbank.service';

@Module({
  imports: [
    PaymentModule,
    HttpModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity])
  ],
  controllers: [SberBankController],
  providers: [SberBankService],
  exports: [SberBankService]
})
export class SberBankModule {}
