import { Controller, Get, Logger, Post, Query, Req, Res } from '@nestjs/common';
import { Response, Request } from 'express';
import {
  ChargeSavedPaymentMethodBody,
  GetPaymentLinkBody,
  IntentResult,
  SetupPayoutMethodBody,
} from '@ridy/database';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private appService: AppService) {}

  @Get()
  async defaultPath(@Res() res: Response) {
    res.send(`✅ Payment Gateways microservice running.\nVersion: 4.0.0`);
  }

  @Post('create_payment_link')
  async createPaymentLink(@Req() req: Request): Promise<IntentResult> {
    return this.appService.createPaymentLink(req.body);
  }

  // Legacy payment redirection, deprecated in favor on new create_payment_link POST method
  @Get('pay')
  async pay(@Query() query: GetPaymentLinkBody, @Res() res: Response) {
    const link = await this.appService.createPaymentLink(query);
    res.redirect(301, link.url!);
  }

  @Get('capture')
  async capturePayment(
    @Query() query: { id: string; amount: string },
  ): Promise<{ status: 'OK' | 'FAILED' }> {
    const link = await this.appService.capturePayment({
      id: query.id,
      amount: parseFloat(query.amount),
    });
    return {
      status: link.status == 'success' ? 'OK' : 'FAILED',
    };
  }

  @Get('cancel_preauth')
  async cancelPreauthPayment(
    @Query() query: { id: string },
  ): Promise<{ status: 'OK' | 'FAILED' }> {
    this.appService.cancelCapture({ id: query.id });
    return {
      status: 'OK',
    };
  }

  // @Get('saved_payment_methods')
  // async getSavedPaymentMethods(
  //   @Req() req: Request<{ Querystring: { userId: string } }>,
  // ): Promise<{ methods: SavedPaymentMethodDto[] }> {
  //   let decrypted = await this.cryptoService.decrypt(req.query.userId);
  //   let userType = decrypted.split('_')[0];
  //   let userId = decrypted.split('_')[1];
  //   let gatewayToUserIds = await this.gatewayToUserRepo.find({
  //     where: { internalUserId: decrypted },
  //     relations: { gateway: true },
  //   });
  //   let paymentMethods: SavedPaymentMethodDto[] = [];
  //   for (let gatewayToUser of gatewayToUserIds) {
  //     switch (gatewayToUser.gateway.type) {
  //       case PaymentGatewayType.Stripe:
  //         let methods = await this.stripService.getCustomerSavedPaymentMethods({
  //           gatewayId: gatewayToUser.gateway.id.toString(),
  //           apiKey: gatewayToUser.gateway.privateKey!,
  //           userType: userType,
  //           userId: userId,
  //         });
  //         paymentMethods.push(...methods);

  //       default:
  //         throw new Error(
  //           'Pre-authentication is not supported for this gateway',
  //         );
  //     }
  //   }
  //   return {
  //     methods: paymentMethods,
  //   };
  // }

  @Post('setup_saved_payment_method')
  async setupSavedPaymentMethod(
    @Req() req: Request<{ Body: { token: string } }>,
    @Res() res: Response,
  ): Promise<IntentResult> {
    Logger.log(req.body.token, 'setupSavedPaymentMethod');
    const result = await this.appService.setupSavedPaymentMethod(
      req.body.token,
    );
    res.send(result);
    return result;
  }

  @Post('charge_saved_payment_method')
  async chargeSavedPaymentMethod(
    @Req()
    req: Request<{
      Body: ChargeSavedPaymentMethodBody;
    }>,
  ): Promise<IntentResult> {
    return this.appService.chargeSavedPaymentMethod(req.body);
  }

  @Post('get_payout_link_url')
  async getPayoutLinkUrl(
    @Req() req: Request<{ Body: SetupPayoutMethodBody }>,
    @Res() res: Response,
  ): Promise<IntentResult> {
    const linkIntentResult = await this.appService.getPayoutLinkUrl(req.body);
    res.send(linkIntentResult);
    return linkIntentResult;
  }

  @Get('/debug-sentry')
  getError() {
    throw new Error('My first Sentry error!');
  }
}
