import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/counter_input/counter_input.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ModalAddWalletBalanceCard extends StatefulWidget {
  const ModalAddWalletBalanceCard({super.key});

  @override
  State<ModalAddWalletBalanceCard> createState() =>
      _ModalAddWalletBalanceCardState();
}

class _ModalAddWalletBalanceCardState extends State<ModalAddWalletBalanceCard> {
  late int _selectedAmount;
  late int _counterValue;
  late String _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _selectedAmount = 10;
    _counterValue = 10;
    _selectedPaymentMethod = 'visa';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 496,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 14,
              bottom: 14,
              left: 20,
              right: 8,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(BetterIcons.wallet01Filled, size: 24),
                ),
                const SizedBox(width: 16),
                Text('Add Wallet Balance', style: context.textTheme.labelLarge),
                const Spacer(),
                AppIconButton(
                  icon: BetterIcons.cancelCircleOutline,
                  iconColor: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 32,
              left: 20,
              right: 20,
            ),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose amount:', style: context.textTheme.titleSmall),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        onPressed: () {
                          setState(() {
                            _selectedAmount = 10;
                            _counterValue = 10;
                          });
                        },
                        text: '\$10',
                        isSelected: _selectedAmount == 10,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Expanded(
                      child: AppOutlinedButton(
                        onPressed: () {
                          setState(() {
                            _selectedAmount = 20;
                            _counterValue = 20;
                          });
                        },
                        text: '\$20',
                        isSelected: _selectedAmount == 20,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Expanded(
                      child: AppOutlinedButton(
                        onPressed: () {
                          setState(() {
                            _selectedAmount = 50;
                            _counterValue = 50;
                          });
                        },
                        text: '\$50',
                        isSelected: _selectedAmount == 50,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppCounterInput(
                    key: ValueKey(_counterValue),
                    initialValue: _counterValue,
                    onChanged: (value) {
                      setState(() {
                        _counterValue = value;
                        if (value != 10 && value != 20 && value != 50) {
                          _selectedAmount = -1;
                        } else {
                          _selectedAmount = value;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select payment method:',
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                AppListItem(
                  leading: Container(
                    padding: const EdgeInsets.all(4),
                    width: 40,
                    height: 40,
                    child: Assets.images.paymentMethods.visaPng.image(
                      width: 32,
                      height: 32,
                    ),
                  ),
                  title: 'Visa card ending with 8748',
                  trailing: AppRadio(
                    value: 'visa',
                    groupValue: _selectedPaymentMethod,
                    onTap: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                    size: RadioSize.medium,
                  ),
                ),
                const SizedBox(height: 8),
                AppListItem(
                  leading: Container(
                    padding: const EdgeInsets.all(4),
                    width: 40,
                    height: 40,
                    child: Assets.images.paymentMethods.paypalPng.image(
                      width: 32,
                      height: 32,
                    ),
                  ),
                  title: 'PayPal',
                  trailing: AppRadio(
                    value: 'paypal',
                    groupValue: _selectedPaymentMethod,
                    onTap: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                    size: RadioSize.medium,
                  ),
                ),
                const SizedBox(height: 8),
                AppListItem(
                  leading: Container(
                    padding: const EdgeInsets.all(4),
                    width: 40,
                    height: 40,
                    child: Assets.images.paymentMethods.stripe.image(
                      width: 32,
                      height: 32,
                    ),
                  ),
                  title: 'Stripe',
                  trailing: AppRadio(
                    value: 'stripe',
                    groupValue: _selectedPaymentMethod,
                    onTap: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                    size: RadioSize.medium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.5),
            child: const AppDivider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Cancel',
                    color: SemanticColor.neutral,
                  ),
                ),
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Confirm & Pay',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
