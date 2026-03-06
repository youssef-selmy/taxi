import 'package:better_design_system/entities/payment_method.entity.dart';

class AddBalanceDialogResult {
  final double amount;
  final PaymentMethodEntity paymentMethod;

  AddBalanceDialogResult({required this.amount, required this.paymentMethod});
}
