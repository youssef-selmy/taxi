import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { InstaMojoController } from './instamojo.controller';
import { InstaMojoService } from './instamojo.service';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity])
  ],
  controllers: [InstaMojoController],
  providers: [InstaMojoService],
  exports: [InstaMojoService]
})
export class InstaMojoModule {}
