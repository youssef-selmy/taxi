import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { MyTMoneyController } from './my-t-money.controller';
import { MyTMoneyService } from './my-t-money.service';

@Module({
  imports: [
    PaymentModule,
    HttpModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity])
  ],
  controllers: [MyTMoneyController],
  providers: [MyTMoneyService],
  exports: [MyTMoneyService]
})
export class MyTMoneyModule {}
