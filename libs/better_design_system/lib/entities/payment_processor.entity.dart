import 'package:image_faker/image_faker.dart';

class PaymentProcessorEntity {
  final String id;
  final String name;
  final String? logoUrl;
  final PaymentProcessorLinkMethod linkMethod;

  PaymentProcessorEntity({
    required this.id,
    required this.name,
    this.logoUrl,
    required this.linkMethod,
  });
}

enum PaymentProcessorLinkMethod { redirect, manual, none }

final mockPaymentProcessor1 = PaymentProcessorEntity(
  id: '1',
  name: 'Debit/Credit Card',
  logoUrl: ImageFaker().paymentGateway.stripe,
  linkMethod: PaymentProcessorLinkMethod.redirect,
);
