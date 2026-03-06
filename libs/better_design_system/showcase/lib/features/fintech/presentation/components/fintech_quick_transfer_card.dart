import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class FintechQuickTransferCard extends StatelessWidget {
  const FintechQuickTransferCard({super.key});

  @override
  Widget build(BuildContext context) {
    final avatars = [
      ImageFaker().person.one,
      ImageFaker().person.two,
      ImageFaker().person.three,
      ImageFaker().person.four,
      ImageFaker().person.five,
      ImageFaker().person.six,
    ];

    final names = ['Mary', 'Brigette', 'Alaric', 'William', 'John'];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quick Transfer', style: context.textTheme.titleSmall),
              AppOutlinedButton(
                onPressed: () {},
                text: 'Advanced',
                prefixIcon: BetterIcons.flashOutline,
                size: ButtonSize.medium,
                color: SemanticColor.neutral,
              ),
            ],
          ),

          AppDivider(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                spacing: 8,
                children: <Widget>[
                  Text(
                    'My Conection',
                    style: context.textTheme.labelLarge?.variant(context),
                  ),
                  AppBadge(
                    text: '18',
                    isRounded: true,
                    color: SemanticColor.primary,
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: <Widget>[
                  AppIconButton(
                    icon: BetterIcons.arrowLeft01Outline,
                    size: ButtonSize.small,
                    style: IconButtonStyle.outline,
                  ),
                  AppIconButton(
                    icon: BetterIcons.arrowRight01Outline,
                    size: ButtonSize.small,
                    style: IconButtonStyle.outline,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  names.length,
                  (index) => AppTag(
                    text: names[index],
                    color: SemanticColor.neutral,
                    prefixImage: avatars[index],
                    size: TagSize.medium,
                    isRounded: true,
                  ),
                ).separated(separator: const SizedBox(width: 8)),
              ],
            ),
          ),
          SizedBox(height: 16),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.outline, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.symmetric(horizontal: 16),
                  childrenPadding: EdgeInsets.zero,
                  title: Row(
                    spacing: 8,
                    children: [
                      Assets.images.paymentMethods.visaPng.image(
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'My Physical Card',
                        style: context.textTheme.bodyMedium?.variant(context),
                      ),
                    ],
                  ),
                  children: [
                    AppDivider(),
                    SizedBox(height: 16),
                    Text(
                      'Enter Amount',
                      style: context.textTheme.labelLarge?.variant(context),
                    ),
                    SizedBox(height: 4),
                    Text('\$0.00', style: context.textTheme.headlineMedium),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceVariant,
                              border: Border(
                                top: BorderSide(color: context.colors.outline),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Available: ',
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                    children: [
                                      TextSpan(
                                        text: '\$12,000,000',
                                        style: context.textTheme.labelMedium,
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
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  onPressed: () {},
                  text: 'Send',
                  isDisabled: true,
                  size: ButtonSize.medium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
