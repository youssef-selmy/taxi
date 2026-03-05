import { HttpService } from '@nestjs/axios';
import {
  Controller,
  ForbiddenException,
  Get,
  Logger,
  Post,
  Req,
  Res,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';
import { firstValueFrom } from 'rxjs';
import { Repository } from 'typeorm';

import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';
import { MIPSService } from './mips.service';

@Controller('mips')
export class MIPSController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
    private mipsService: MIPSService,
    private httpService: HttpService,
  ) {}

  @Post('callback')
  async callback(
    @Req()
    req: Request<{
      Querystring: { id_order: string };
      Body: { posted_data: string };
    }>,
    @Res() res: Response,
  ) {
    Logger.log(
      `Verify Mips called with query: ${JSON.stringify(
        req.query,
      )} & body: ${JSON.stringify(req.body)}`,
    );
    let payment = await this.paymentService.getOne(req.query.id_order);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const paymentMethod = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    const decrypted = await this.mipsService.getMipsDecrypted(
      paymentMethod,
      req.body.posted_data,
    );
    Logger.log(JSON.stringify(decrypted));
    await this.paymentService.updatePaymentStatus(
      payment.id,
      decrypted.status.toLowerCase() == 'success'
        ? PaymentStatus.Success
        : PaymentStatus.Canceled,
    );
    payment = await this.paymentService.getOne(req.query.id_order);
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    await firstValueFrom(
      this.httpService.get(`${payment.returnUrl}?token=${encrypted}`),
    );
    res.send(200);
  }
}
