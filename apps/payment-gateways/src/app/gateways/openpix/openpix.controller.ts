import {
  Controller,
  ForbiddenException,
  Get,
  Logger,
  Post,
  Req,
  Res,
} from '@nestjs/common';
import { Response, Request } from 'express';

import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';
import { InjectRepository } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '@ridy/database';
import { Repository } from 'typeorm';
import { stat } from 'fs';

@Controller('openpix')
export class OpenPixController {
  constructor(
    private paymentService: PaymentService,
    @InjectRepository(PaymentGatewayEntity)
    private paymentGatewayRepository: Repository<PaymentGatewayEntity>,
  ) {}

  @Post('callback')
  async callback(
    @Req()
    req: Request<{
      Body: {
        charge: {
          status: 'COMPLETED' | 'ACTIVE' | 'EXPIRED';
          correlationID: string;
          transactionID: string;
        };
      };
    }>,
    @Res() res: Response,
  ) {
    Logger.log(
      `callback query:${JSON.stringify(req.body)}`,
      'OpenPixController',
    );
    if (req.body?.charge == null) {
      res.send(200);
      return;
    }
    let payment = await this.paymentService.getOne(
      req.body.charge.correlationID,
    );
    if (payment != null) {
      const status: 'COMPLETED' | 'EXPIRED' | 'ACTIVE' = req.body.charge.status;
      if (status === 'ACTIVE') {
        res.send(200);
        return;
      }
      payment = await this.paymentService.updatePaymentStatus(
        payment.id,
        status === 'COMPLETED' ? PaymentStatus.Success : PaymentStatus.Failed,
      );
      const encrypted =
        await this.paymentService.getEncryptedWithPayment(payment);
      res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
    } else {
      res.send(200);
    }
  }
}
