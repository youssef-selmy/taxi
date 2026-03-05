import { Injectable, Logger } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import * as crypto from "crypto";

@Injectable()
export class MIPSService {
    constructor() {}

    async getPaymentLink(input: { gateway: PaymentGatewayEntity, userType: string, userId: string, currency: string, amount: string}): Promise<PaymentLinkResult> {
        const transactionId=`${input.userType}_${input.userId}_${new Date().getTime()}`;
        const idMerchant = input.gateway.merchantId;
        const idForm = input.gateway.publicKey;
        const salt = input.gateway.saltKey;
        const cipherKey = input.gateway.privateKey!;
        const checkSumData = `${idForm}${transactionId}${parseInt(input.amount) * 100}${input.currency}${salt}`;
        const checksum = crypto.createHash('sha256').update(checkSumData).digest('hex');
        const jsonData = {
            id_form: idForm,
            id_order: transactionId,
            amount: parseInt(input.amount) * 100,
            currency: input.currency,
            checksum: checksum
        };
        const cipher = crypto.createCipheriv('AES-128-ECB', cipherKey.substring(0,16), Buffer.alloc(0));
        let cp = cipher.update(JSON.stringify(jsonData), 'utf8', "base64");
        cp += cipher.final('base64');
        const base64Encoded = Buffer.from(cp, 'utf8').toString('base64');
        Logger.log(`calling mips with base64: ${base64Encoded}`);
        return {
            url: `https://go.mips.mu/mipsit.php?c=${base64Encoded}&smid=${idMerchant}`,
            invoiceId: transactionId
        };
    }

    async getMipsDecrypted(gateway: PaymentGatewayEntity, token: string): Promise<ChargeDecryptedKey> {
        const salt = gateway.saltKey;
        const cipherKey = gateway.privateKey!;
        const postedData = Buffer.from(token, 'base64').toString();
        const decipher = crypto.createDecipheriv('aes-128-ecb', cipherKey.substring(0, 16), Buffer.alloc(0));
        const preDecrypted = decipher.update(postedData, 'base64', 'utf8');
        const decrypted: ChargeDecryptedKey = JSON.parse((preDecrypted + decipher.final('utf8')));
        const checkSumData = crypto.createHash('sha256').update(`${decrypted.amount}${decrypted.currency}${decrypted.status}${salt}`).digest('hex');
        if (decrypted.checksum == checkSumData) {
            if (decrypted.status.toLowerCase() == 'success') {
                return decrypted;
            } else {
                throw new Error(decrypted.status);
            }
        } else {
            throw new Error('Invalid Request');
        }
    }
}

export interface ChargeDecryptedKey {
    amount: string,
    currency: string,
    status: 'success' | 'failed',
    checksum: string
}