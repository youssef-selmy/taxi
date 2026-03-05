import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CryptoService } from '../crypto/crypto.service';
import { PaymentEntity, PaymentStatus } from '../database/payment.entity';
import { DecryptedPaymentResult, GetPaymentLinkBody } from '@ridy/database';

@Injectable()
export class PaymentService {
  constructor(
    @InjectRepository(PaymentEntity)
    public paymentRepository: Repository<PaymentEntity>,
    private cryptoService: CryptoService,
  ) {}

  async createRecord(input: {
    transactionNumber: string;
    externalReferenceNumber?: string;
    orderNumber?: string;
    paymentInterface: GetPaymentLinkBody;
  }) {
    await this.paymentRepository.insert({
      amount: parseFloat(input.paymentInterface.amount),
      currency: input.paymentInterface.currency,
      transactionNumber: input.transactionNumber,
      externalReferenceNumber: input.externalReferenceNumber,
      userId: input.paymentInterface.userId,
      userType: input.paymentInterface.userType,
      gatewayId: input.paymentInterface.paymentGatewayId,
      orderNumber: input.orderNumber,
      returnUrl: input.paymentInterface.returnUrl.replace('"', ''),
    });
  }

  async getOne(transactionNumber: string): Promise<PaymentEntity> {
    return this.paymentRepository.findOneOrFail({
      where: { transactionNumber },
    });
  }

  async getOneByExternalReferenceNumber(
    externalReferenceNumber: string,
  ): Promise<PaymentEntity> {
    return this.paymentRepository.findOneOrFail({
      where: { externalReferenceNumber },
    });
  }

  async markAsCaptured(id: number, amount: number): Promise<PaymentEntity> {
    await this.paymentRepository.update(id, {
      status: PaymentStatus.Success,
      amount: amount,
    });
    return this.paymentRepository.findOneByOrFail({ id });
  }

  async markAsCanceled(id: number): Promise<PaymentEntity> {
    await this.paymentRepository.update(id, {
      status: PaymentStatus.Canceled,
    });
    return this.paymentRepository.findOneByOrFail({ id });
  }

  async getEncryptedWithPayment(payment: PaymentEntity): Promise<string> {
    // const result = `${payment.userType}|${payment.userId}|${new Date().getTime()}|${payment.gatewayId}|${payment.transactionNumber}`;
    const json: DecryptedPaymentResult = {
      status: payment.status,
      userType: payment.userType,
      userId: parseInt(payment.userId),
      timestamp: new Date().getTime(),
      gatewayId: payment.gatewayId!,
      transactionNumber: payment.transactionNumber,
      orderId: payment.orderNumber ? parseInt(payment.orderNumber) : undefined,
      amount: payment.amount,
      currency: payment.currency,
    };
    const str = JSON.stringify(json);
    return this.cryptoService.encrypt(str);
  }

  async updatePaymentStatus(id: number, status: PaymentStatus) {
    await this.paymentRepository.update(id, { status: status });
    return this.paymentRepository.findOneByOrFail({ id });
  }
}
