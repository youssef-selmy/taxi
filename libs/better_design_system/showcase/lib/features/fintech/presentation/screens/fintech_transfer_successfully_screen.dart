import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/router/app_router.dart';
import 'package:better_design_showcase/features/fintech/presentation/blocs/navigator.cubit.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FintechTransferSuccessfullyScreen extends StatelessWidget {
  const FintechTransferSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 48),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.colors.successContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    BetterIcons.checkmarkCircle02Filled,
                    size: 48,
                    color: context.colors.success,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Transfer Processed Successfully',
                  style: context.textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Text(
                  'The transfer of \$100.00 to Kevin Yates was successful',
                  style: context.textTheme.bodyMedium?.variant(context),
                ),

                SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Details Transaction',
                            style: context.textTheme.titleSmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.colors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.colors.outline),
                        ),
                        child: Column(
                          children: <Widget>[
                            _getTransactionDetailItme(
                              context,
                              title: 'Transaction ID',
                              value: '98213669',
                            ),
                            _getTransactionDetailItme(
                              context,
                              title: 'Date',
                              value: 'Oct 11, 2024',
                            ),
                            _getTransactionDetailItme(
                              context,
                              title: 'Time',
                              value: '9:21 pm',
                            ),
                            _getTransactionDetailItme(
                              context,
                              title: 'Amount',
                              value: '\$100',
                            ),
                            _getTransactionDetailItme(
                              context,
                              title: 'Charge',
                              value: '\$10',
                            ),
                            _getTransactionDetailItme(
                              context,
                              title: 'Note',
                              value: 'Good luck 💜',
                            ),

                            AppDivider(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: context.textTheme.titleSmall,
                                ),
                                Text(
                                  '\$110',
                                  style: context.textTheme.headlineLarge
                                      ?.copyWith(color: context.colors.primary),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              spacing: 12,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppOutlinedButton(
                                    onPressed: () {},
                                    text: 'Share',
                                    prefixIcon: BetterIcons.share07Outline,
                                    color: SemanticColor.neutral,
                                  ),
                                ),
                                Expanded(
                                  child: AppOutlinedButton(
                                    onPressed: () {},
                                    text: 'Print',
                                    prefixIcon: BetterIcons.file02Outline,
                                    color: SemanticColor.neutral,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          AppDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {
                      context.read<NavigatorCubit>().onNavigationItemTapped(
                        FintechHomeRoute(),
                      );
                      context.router.replaceAll([FintechHomeRoute()]);
                    },
                    text: 'Back Home',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTransactionDetailItme(
    BuildContext context, {
    required String title,
    required String value,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.labelLarge?.variant(context)),
        Text(value, style: context.textTheme.labelLarge),
      ],
    ),
  );
}
