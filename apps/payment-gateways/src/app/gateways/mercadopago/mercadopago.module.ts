import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { MercadopagoController } from './mercadopago.controller';
import { MercadopagoService } from './mercadopago.service';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity])
  ],
  controllers: [MercadopagoController],
  providers: [MercadopagoService],
  exports: [MercadopagoService]
})
export class MercadopagoModule {}
