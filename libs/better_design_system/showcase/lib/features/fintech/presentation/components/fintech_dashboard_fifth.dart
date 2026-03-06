import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import '../dialogs/fintech_card_detail_dialog.dart';
import 'fintech_saved_payment_method_card.dart';
import 'fintech_sidebar.dart';
import 'fintech_spending_card.dart';
import 'fintech_transactions_table.dart';

class FintechDashboardFifth extends StatelessWidget {
  final Widget? header;
  const FintechDashboardFifth({super.key, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FintechSidebar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Row(
                          spacing: 12,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: context.colors.surface,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: context.colors.outline,
                                ),
                              ),
                              child: Icon(
                                BetterIcons.wallet01Outline,
                                color: context.colors.onSurfaceVariant,
                                size: 32,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  'Your Balance',
                                  style: context.textTheme.labelLarge?.variant(
                                    context,
                                  ),
                                ),
                                Text(
                                  '\$30,710.80',
                                  style: context.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              width: 270,
                              child: AppTextField(
                                density: TextFieldDensity.dense,
                                hint: 'Search',
                                prefixIcon: Icon(
                                  BetterIcons.search01Filled,
                                  color: context.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                                suffixIcon: Icon(
                                  BetterIcons.filterVerticalOutline,
                                  color: context.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                              ),
                            ),

                            AppNavbarIcon(
                              icon: BetterIcons.notification02Outline,
                            ),

                            AppOutlinedButton(
                              onPressed: () {},
                              text: 'Receive money',
                              color: SemanticColor.neutral,
                            ),

                            AppFilledButton(
                              onPressed: () {},
                              text: 'Quick transaction',
                              prefixIcon:
                                  BetterIcons.arrowDataTransferHorizontalFilled,
                              color: SemanticColor.primary,
                            ),

                            AppAvatar(
                              imageUrl: ImageFaker().person.one,
                              size: AvatarSize.size40px,
                            ),
                          ],
                        ),
                      ),
                      AppDivider(),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          spacing: 24,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 24,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 8,
                                      children: [
                                        Icon(
                                          BetterIcons.creditCardOutline,
                                          size: 24,
                                          color:
                                              context.colors.onSurfaceVariant,
                                        ),
                                        Text(
                                          'My Cards',
                                          style: context.textTheme.titleSmall,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 12,
                                      children: [
                                        AppOutlinedButton(
                                          onPressed: () {},
                                          text: 'All Cards',
                                          color: SemanticColor.neutral,
                                        ),
                                        AppFilledButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (context) =>
                                                      FintechCardDetailDialog(),
                                            );
                                          },
                                          text: 'Request new',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Row(
                                  spacing: 16,
                                  children: <Widget>[
                                    FintechSavedPaymentMethodCard(
                                      cardSubtitle: 'Physical **** 5969',
                                      displayValue: '\$5,163.21',
                                      style:
                                          SavedPaymentMethodStyle
                                              .gradientPurple,
                                    ),
                                    FintechSavedPaymentMethodCard(
                                      cardSubtitle: 'Virtual **** 9612',
                                      displayValue: '\$6,452.36',
                                      style:
                                          SavedPaymentMethodStyle.gradientRed,
                                    ),
                                    FintechSavedPaymentMethodCard(
                                      cardSubtitle: 'Virtual **** 8102',
                                      displayValue: '\$4,589.48',
                                      style:
                                          SavedPaymentMethodStyle.gradientBlue,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              children: <Widget>[
                                Expanded(child: FintechSpendingCard()),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(child: FintechTransactionsTable()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
