class PaymentProcessorLinkIntentResultEntity {
  final String? url;
  final String? error;
  final PaymentProcessorLinkIntentResultState state;

  PaymentProcessorLinkIntentResultEntity({
    this.url,
    this.error,
    required this.state,
  });
}

enum PaymentProcessorLinkIntentResultState { error, redirect }
