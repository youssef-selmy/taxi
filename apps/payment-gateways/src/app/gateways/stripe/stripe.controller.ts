import {
  Controller,
  ForbiddenException,
  Get,
  Logger,
  Post,
  Req,
  Res,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { InjectRepository } from '@nestjs/typeorm';

import { DeepPartial, Repository } from 'typeorm';
import { PaymentService } from '../../payment/payment.service';
import { StripeService } from './stripe.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import Stripe from 'stripe';
import { SavedPaymentMethodEntity } from '@ridy/database';
import { SavedPaymentMethodType } from '@ridy/database';

@Controller('stripe')
export class StripeController {
  constructor(
    private stripeService: StripeService,
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    @InjectRepository(SavedPaymentMethodEntity)
    private savedPaymentMethodRepository: Repository<SavedPaymentMethodEntity>,
    private paymentService: PaymentService,
  ) {}

  // @Get('redirect')
  // async redirect(@Req() req: Request<{Querystring: {sessionId: string, publicKey: string}}>, @Res() res: Response) {
  //     const html = `<html><head><title>Redirecting to stripe</title> <script src="https://js.stripe.com/v3/"></script> </head><body> <script type="text/javascript">var stripe=Stripe('${req.query.publicKey}');stripe.redirectToCheckout({sessionId:'${req.query.sessionId}'}).then(function(result){if(result.error){alert(result.error.message);}}).catch(function(error){console.error('Error:',error);});</script> </body></html>`;
  //     res.send(html);
  // }

  @Post('webhook')
  async webHook(@Req() req: Request, @Res() res: Response) {
    res.send({ status: 'OK' });
  }

  @Get('success')
  async verify(
    @Req() req: Request<{ Querystring: { session_id: string } }>,
    @Res() res: Response,
  ) {
    // Fallback for getting sessionId from URL if req.query is empty
    const sessionId = (req.query.session_id ||
      new URLSearchParams(req.url?.split('?')[1] || '').get(
        'session_id',
      )) as string;

    Logger.log(
      'Extracted sessionId: ' + sessionId,
      'StripeController.verify.sessionId',
    );

    if (!sessionId) {
      throw new ForbiddenException('Session ID not provided.');
    }

    let payment =
      await this.paymentService.getOneByExternalReferenceNumber(sessionId);
    Logger.log(payment, 'StripeController.verify.payment');
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const paymentMethod = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    Logger.log(paymentMethod, 'StripeController.verify.paymentMethod');
    const verify = await this.stripeService.verify(
      paymentMethod,
      payment.externalReferenceNumber!,
    );
    Logger.log(verify, 'StripeController.verify.verify');
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      this.getPaymentStatusForPayment(verify),
    );

    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }

  @Get('cancel')
  async cancel(
    @Req() req: Request<{ Querystring: { transactionId: string } }>,
    @Res() res: Response,
  ) {
    let payment = await this.paymentService.getOne(
      req.query.transactionId as string,
    );
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      PaymentStatus.Canceled,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }

  @Get('success_charge_saved_payment_method')
  async successChargeSavedPaymentMethod(
    @Req()
    req: Request<{ Querystring: { transactionNumber: string } }>,
    @Res() res: Response,
  ) {
    const payment = await this.stripeService.successChargeSavedPaymentMethod(
      req.query.transactionNumber as string,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }

  @Get('cancel_attach')
  async cancelAttach(
    @Req() req: Request<{ Querystring: { session_id: string } }>,
    @Res() res: Response,
  ) {
    const sessionId = req.query.session_id as string;
    Logger.log(sessionId, 'StripeController.cancelAttach.sessionId');
    const payment = await this.paymentService.paymentRepository.findOneOrFail({
      where: { externalReferenceNumber: sessionId },
    });
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }

  @Get('success_attach')
  async successAttach(
    @Req() req: Request<{ Querystring: { session_id: string } }>,
    @Res() res: Response,
  ) {
    const url = req.url;
    Logger.log(url, 'StripeController.successAttach.url');
    const sessionId = req.query.session_id as string;
    // Logger.log(req.query, 'StripeController.successAttach.query');
    const payment = await this.paymentService.paymentRepository.findOneOrFail({
      where: { externalReferenceNumber: sessionId },
    });
    // Logger.log(
    //   JSON.stringify(payment),
    //   'StripeController.successAttach.payment',
    // );
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    // Logger.log(
    //   JSON.stringify(gateway),
    //   'StripeController.successAttach.gateway',
    // );
    const session = await this.stripeService.getSession(gateway, sessionId);
    // Logger.log(
    //   JSON.stringify(session),
    //   'StripeController.successAttach.session',
    // );
    const paymentMethod =
      await this.stripeService.getSetupIntentPaymentMethodDetails(
        gateway,
        session.setup_intent! as string,
      );
    // Logger.log(
    //   JSON.stringify(paymentMethod),
    //   'StripeController.successAttach.paymentMethod',
    // );
    this.savedPaymentMethodRepository.update(
      {
        riderId:
          payment.userType == 'rider' ? parseInt(payment.userId!) : undefined,
        driverId:
          payment.userType == 'driver' ? parseInt(payment.userId!) : undefined,
      },
      {
        isDefault: false,
      },
    );
    const expiryYear = paymentMethod.card?.exp_year;

    const expiryMonth = paymentMethod.card?.exp_month;
    const method: DeepPartial<SavedPaymentMethodEntity> = {
      riderId:
        payment.userType == 'rider' ? parseInt(payment.userId!) : undefined,
      driverId:
        payment.userType == 'driver' ? parseInt(payment.userId!) : undefined,
      paymentGatewayId: payment.gatewayId,
      token: paymentMethod.id,
      type: SavedPaymentMethodType.CARD,
      isDefault: true,
      lastFour: paymentMethod.card?.last4,
      holderName: paymentMethod.billing_details?.name ?? '-',
      providerBrand: paymentMethod.card?.brand as any,
      title:
        (paymentMethod.card?.last4
          ? paymentMethod.card?.last4
          : paymentMethod.card?.brand) ?? '-',
    };
    if (expiryYear && expiryMonth) {
      method.expiryDate = new Date(
        `${expiryYear}-${expiryMonth}-01T00:00:00.000Z`,
      );
    }
    this.savedPaymentMethodRepository.save(method);
    res.redirect(301, payment.returnUrl);
  }

  getPaymentStatusForPayment(session: Stripe.Checkout.Session): PaymentStatus {
    if (session.status == 'complete' && session.payment_status == 'unpaid') {
      return PaymentStatus.Authorized;
    }
    if (session.status == 'complete' && session.payment_status == 'paid') {
      return PaymentStatus.Success;
    }
    return PaymentStatus.Failed;
  }
}
