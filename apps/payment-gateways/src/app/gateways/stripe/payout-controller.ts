import { Controller, Get, Logger, Req, Res } from '@nestjs/common';
import { Response, Request } from 'express';
import { StripePayoutService } from './payout-service';
import Stripe from 'stripe';
import { PayoutService } from '../../payment/payout.service';
import { SavedPaymentMethodType } from '@ridy/database';

@Controller('stripe/payout')
export class StripePayoutController {
  constructor(
    private stripePayoutService: StripePayoutService,
    private payoutService: PayoutService,
  ) {}

  @Get('refresh')
  async refresh(
    @Req() req: Request<{ Querystring: { transactionId: string } }>,
    @Res() res: Response,
  ) {
    return 'Link url expired, please try again.';
  }

  @Get('return')
  async return(
    @Req()
    req: Request<{
      Querystring: { account_id: string; payout_method_id: number };
    }>,
    @Res() res: Response,
  ) {
    const method = await this.stripePayoutService.getStripePayoutMethod(
      req.query.payout_method_id as unknown as number,
    );
    const instance = new Stripe(method.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    const account = await instance.accounts.retrieve(
      req.query.account_id as string,
      {
        expand: ['external_accounts', 'external_accounts.data.customer'],
      },
    );
    if (!account.metadata!.userId) {
      throw new Error('Invalid account, it is not linked to any user.');
    }
    Logger.log(
      `Linking account ${account.id} to user ${account.metadata!.userId}`,
    );
    Logger.log(account, 'StripePayoutController.return.account');
    const externalAccounts: Array<Stripe.BankAccount | Stripe.Card> =
      account.external_accounts!.data;
    const defaultAccount = externalAccounts.find(
      (account) => account.default_for_currency,
    );
    if (defaultAccount == null) {
      throw new Error('No default account found.');
    }
    if (defaultAccount.object == 'bank_account') {
      const bankAccount = defaultAccount as Stripe.BankAccount;
      await this.payoutService.linkPayoutAccount({
        driverId: parseInt(account.metadata!.userId),
        payoutMethodId: parseInt(req.query.payout_method_id as string),
        token: account.id,
        name: bankAccount.bank_name!,
        type: SavedPaymentMethodType.BANK_ACCOUNT,
        currency: bankAccount.currency!,
        last4: bankAccount.last4!,
        accountNumber: bankAccount.last4!,
        accountHolderName: bankAccount.account_holder_name ?? undefined,
      });
    } else {
      const card = defaultAccount as Stripe.Card;
      await this.payoutService.linkPayoutAccount({
        driverId: parseInt(account.metadata!.userId),
        payoutMethodId: parseInt(req.query.payout_method_id as string),
        token: account.id,
        name: card.brand!,
        type: SavedPaymentMethodType.CARD,
        currency: card.currency!,
        last4: card.last4!,
        accountHolderName: card.name ?? undefined,
        accountHolderState: card.address_state ?? undefined,
        accountHolderZip: card.address_zip ?? undefined,
        accountHolderAddress: card.address_line1 ?? undefined,
        accountHolderCity: card.address_city ?? undefined,
        accountHolderCountry: card.address_country ?? undefined,
      });
    }

    if (account.metadata?.return_url != null) {
      res.redirect(301, account.metadata!.return_url);
    } else {
      res.send('Account linked successfully.');
    }
  }
}
