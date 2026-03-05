import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { MyFatoorahController } from './myfatoorah.controller';
import { MyFatoorahService } from './myfatoorah.service';

@Module({
  imports: [
    PaymentModule,
    HttpModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity])
  ],
  controllers: [MyFatoorahController],
  providers: [MyFatoorahService],
  exports: [MyFatoorahService]
})
export class MyFatoorahModule {}
