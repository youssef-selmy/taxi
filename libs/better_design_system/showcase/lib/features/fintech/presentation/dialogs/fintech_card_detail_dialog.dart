import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import '../components/fintech_saved_payment_method_card.dart';

class FintechCardDetailDialog extends StatelessWidget {
  const FintechCardDetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      title: 'Card Details',
      icon: BetterIcons.creditCardOutline,
      iconColor: SemanticColor.neutral,
      iconStyle: DialogHeaderIconStyle.withBorder,
      defaultDialogType: DialogType.rightSheet,
      desktopDialogType: DialogType.rightSheet,
      onClosePressed: () {
        context.router.pop();
      },
      contentPadding: EdgeInsets.zero,

      child: SingleChildScrollView(
        child: Column(
          children: [
            AppDivider(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: FintechSavedPaymentMethodCard(
                          cardSubtitle: 'Niklaus Mikaelson',
                          displayValue: '**** **** **** 7788',
                          expireDate: '01/02',
                          style: SavedPaymentMethodStyle.gradientRed,
                          type: SavedPaymentMethodType.cardNumber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Marketing - Virtual',
                        style: context.textTheme.bodyLarge,
                      ),
                      AppTag(text: 'Active', color: SemanticColor.success),
                    ],
                  ),

                  AppDivider(height: 40),

                  Text('Details', style: context.textTheme.titleSmall),

                  SizedBox(height: 16),

                  Column(
                    spacing: 16,
                    children: [
                      _detailField(
                        context,
                        title: 'Cardholder name',
                        value: 'Niklaus Mikaelson',
                      ),
                      _detailField(
                        context,
                        title: 'Card Number',
                        value: '5036 9875 5655 2148',
                      ),
                      _detailField(
                        context,
                        title: 'Expiry Date',
                        value: '09/2025',
                      ),
                    ],
                  ),
                  AppDivider(height: 40),

                  Text('Activity', style: context.textTheme.titleSmall),
                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Spent This Month',
                        style: context.textTheme.labelLarge,
                      ),
                      Row(
                        spacing: 4,
                        children: <Widget>[
                          Icon(
                            BetterIcons.loading03Outline,
                            size: 20,
                            color: context.colors.onSurface,
                          ),

                          Text.rich(
                            TextSpan(
                              text: '\$250.87 ',
                              style: context.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: '/ 1000',
                                  style: context.textTheme.bodyMedium?.variant(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  AppLinearProgressBar(
                    linearProgressBarStatus: LinearProgressBarStatus.uploading,
                    progress: 0.25,
                  ),
                  AppDivider(height: 40),
                  Text('Card Setting', style: context.textTheme.titleSmall),
                  SizedBox(height: 16),
                  Column(
                    spacing: 16,
                    children: [
                      _settingField(context, value: 'Transaction'),
                      _settingField(context, value: 'Edit Limit'),
                      _settingField(context, value: 'Personalization'),
                      _settingField(context, value: 'Change PIN'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailField(
    BuildContext context, {
    required String title,
    required String value,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8,
    children: <Widget>[
      Text(title, style: context.textTheme.labelLarge?.variant(context)),
      Container(
        padding: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 12),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colors.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: context.textTheme.bodyMedium),

            Icon(
              BetterIcons.copyOutline,
              size: 20,
              color: context.colors.onSurface,
            ),
          ],
        ),
      ),
    ],
  );

  Widget _settingField(BuildContext context, {required String value}) =>
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colors.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: context.textTheme.bodyMedium),
            Icon(
              BetterIcons.arrowRight01Outline,
              size: 24,
              color: context.colors.onSurfaceVariant,
            ),
          ],
        ),
      );
}
