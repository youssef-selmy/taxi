import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

import '../components/fintech_saved_payment_methods_carousel.dart';

@RoutePage()
class FintechHomeScreen extends StatefulWidget {
  const FintechHomeScreen({super.key});

  @override
  State<FintechHomeScreen> createState() => _FintechHomeScreenState();
}

class _FintechHomeScreenState extends State<FintechHomeScreen> {
  final List<String> transactionsTab = ['Payment', 'Receive'];

  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = transactionsTab.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AppProfileButton(
                          avatarUrl: ImageFaker().person.one,
                          statusBadge: StatusBadgeType.online,
                          title: 'Hi, Sara 👋',
                        ),

                        Row(
                          spacing: 8,
                          children: <Widget>[
                            AppIconButton(
                              onPressed: () {},
                              icon: BetterIcons.search01Filled,
                            ),
                            AppIconButton(
                              onPressed: () {},
                              icon: BetterIcons.notification02Outline,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Total Balance',
                    style: context.textTheme.labelLarge?.variant(context),
                  ),
                  SizedBox(height: 8),
                  Text('\$17,000,000', style: context.textTheme.headlineLarge),

                  SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Card', style: context.textTheme.titleSmall),
                      AppOutlinedButton(
                        onPressed: () {},
                        prefixIcon: BetterIcons.add01Outline,
                        text: 'Add new Card',
                        size: ButtonSize.medium,
                        color: SemanticColor.neutral,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  FintechSavedPaymentMethodsCarousel(),
                ],
              ),
            ),
            SizedBox(height: 24),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children: <Widget>[
                  AppOutlinedButton(
                    onPressed: () {},
                    text: 'Top-up',
                    prefixIcon: BetterIcons.add01Outline,
                    color: SemanticColor.neutral,
                    borderRadius: BorderRadius.circular(100),
                    size: ButtonSize.medium,
                  ),
                  AppOutlinedButton(
                    onPressed: () {},
                    text: 'Transfer',
                    prefixIcon: BetterIcons.arrowDataTransferHorizontalOutline,
                    color: SemanticColor.neutral,
                    borderRadius: BorderRadius.circular(100),
                    size: ButtonSize.medium,
                  ),
                  AppOutlinedButton(
                    onPressed: () {},
                    text: 'Withdraw',
                    prefixIcon: BetterIcons.arrowDown03Outline,
                    color: SemanticColor.neutral,
                    borderRadius: BorderRadius.circular(100),
                    size: ButtonSize.medium,
                  ),
                  AppOutlinedButton(
                    onPressed: () {},
                    text: 'Payment',
                    prefixIcon: BetterIcons.dollarCircleOutline,
                    color: SemanticColor.neutral,
                    borderRadius: BorderRadius.circular(100),
                    size: ButtonSize.medium,
                  ),
                  AppOutlinedButton(
                    onPressed: () {},
                    text: 'More',
                    prefixIcon: BetterIcons.dashboardSquare01Outline,
                    color: SemanticColor.neutral,
                    borderRadius: BorderRadius.circular(100),
                    size: ButtonSize.medium,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            border: Border.all(color: context.colors.outline),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            spacing: 24,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Analytics',
                                style: context.textTheme.titleSmall,
                              ),
                              Row(
                                spacing: 24,
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 12,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              spacing: 8,
                                              children: <Widget>[
                                                BetterDotBadge(
                                                  dotBadgeSize:
                                                      DotBadgeSize.large,
                                                  color: SemanticColor.primary,
                                                ),
                                                Text(
                                                  'Income',
                                                  style: context
                                                      .textTheme
                                                      .labelLarge
                                                      ?.variant(context),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '\$5,890.35',
                                              style:
                                                  context.textTheme.labelLarge,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              spacing: 8,
                                              children: <Widget>[
                                                BetterDotBadge(
                                                  dotBadgeSize:
                                                      DotBadgeSize.large,
                                                  color: SemanticColor.warning,
                                                ),
                                                Text(
                                                  'Outcome',
                                                  style: context
                                                      .textTheme
                                                      .labelLarge
                                                      ?.variant(context),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '\$2,741.13',
                                              style:
                                                  context.textTheme.labelLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  _StackedCircularProgress(
                                    values: [0.5, 0.3],
                                    colors: [
                                      context.colors.primary,
                                      context.colors.warning,
                                    ],
                                    size: 100,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Recent Transactions',
                    style: context.textTheme.titleSmall,
                  ),
                  SizedBox(height: 16),
                  AppToggleSwitchButtonGroup<String>(
                    isExpanded: true,
                    options:
                        transactionsTab
                            .map(
                              (e) => ToggleSwitchButtonGroupOption(
                                value: e,
                                label: e,
                              ),
                            )
                            .toList(),
                    selectedValue: selectedTab,
                    onChanged: (value) {
                      setState(() {
                        selectedTab = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),

                  Column(
                    children: [
                      _getTransactionItem(
                        context,
                        icon: BetterIcons.hamburger01Filled,
                        iconColor: context.colors.warning,
                        title: 'Food',
                        subtitle: '05 / 2025',
                        price: '\$100',
                      ),
                      AppDivider(height: 36),
                      _getTransactionItem(
                        context,
                        icon: BetterIcons.fireFilled,
                        iconColor: context.colors.warning,
                        title: 'Gas bill',
                        subtitle: '05 / 2025',
                        price: '\$35',
                      ),
                      AppDivider(height: 36),
                      _getTransactionItem(
                        context,
                        icon: BetterIcons.car05Filled,
                        iconColor: context.colors.primary,
                        title: 'Car Gasoline',
                        subtitle: '05 / 2025',
                        price: '\$30',
                      ),
                      AppDivider(height: 36),
                      _getTransactionItem(
                        context,
                        icon: BetterIcons.building02Filled,
                        iconColor: context.colors.onSurfaceVariant,
                        title: 'School Tuition',
                        subtitle: '05 / 2025',
                        price: '\$350',
                      ),
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

  Widget _getTransactionItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String price,
  }) => Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(color: context.colors.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
      SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.textTheme.labelLarge),
          Text(subtitle, style: context.textTheme.bodySmall?.variant(context)),
        ],
      ),
      Spacer(),
      Text(price, style: context.textTheme.labelLarge),
    ],
  );
}

class _StackedCircularProgress extends StatelessWidget {
  final List<double> values;
  final List<Color> colors;
  final double size;

  const _StackedCircularProgress({
    required this.values,
    required this.colors,
    this.size = 100,
  }) : assert(
         values.length == colors.length,
         'values & colors length mismatch',
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ArcPainter(
              value: 1,
              color: context.colors.surfaceVariant,
              strokeWidth: 12,
            ),
          ),

          for (int i = 0; i < values.length; i++)
            CustomPaint(
              size: Size(size, size),
              painter: _ArcPainter(
                value: values[i],
                color: colors[i],
                strokeWidth: 12,
              ),
            ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;

  _ArcPainter({
    required this.value,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - strokeWidth / 2,
    );

    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * value;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}
