import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { OpenPixService } from './openpix.service';
import { OpenPixController } from './openpix.controller';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [
    PaymentModule,
    HttpModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity]),
  ],
  controllers: [OpenPixController],
  providers: [OpenPixService],
  exports: [OpenPixService],
})
export class OpenPixModule {}
