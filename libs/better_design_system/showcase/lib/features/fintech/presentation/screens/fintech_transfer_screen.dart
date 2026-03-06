import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/router/app_router.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/bordered_toggle_button.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_faker/image_faker.dart';

import '../blocs/navigator.cubit.dart';

enum _TransferScreenMode { contacts, transferForm }

@RoutePage()
class FintechTransferScreen extends StatefulWidget {
  const FintechTransferScreen({super.key});

  @override
  State<FintechTransferScreen> createState() => _FintechTransferScreenState();
}

class _FintechTransferScreenState extends State<FintechTransferScreen> {
  final contacts = [
    _Contact(
      imageUrl: ImageFaker().person.one,
      name: 'Julia Phillips',
      phone: '323-517-8010',
    ),
    _Contact(
      imageUrl: ImageFaker().person.two,
      name: 'Michael Scott',
      phone: '212-555-0172',
    ),
    _Contact(
      imageUrl: ImageFaker().person.three,
      name: 'Pam Beesly',
      phone: '646-123-4567',
    ),
    _Contact(
      imageUrl: ImageFaker().person.four,
      name: 'Jim Halpert',
      phone: '718-555-0199',
    ),
    _Contact(
      imageUrl: ImageFaker().person.five,
      name: 'Molly L. Murch',
      phone: '315-826-4613',
    ),
  ];
  _TransferScreenMode screenMode = _TransferScreenMode.contacts;

  final List<String> amounts = [
    '\$25.00',
    '\$50.00',
    '\$100.00',
    '\$150.00',
    '\$200.00',
    '\$250.00',
  ];

  String? selectedAmount;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: AppMobileTopBar(
                    onBackPressed: () {
                      if (screenMode == _TransferScreenMode.contacts) {
                        context.read<NavigatorCubit>().onNavigationItemTapped(
                          FintechHomeRoute(),
                        );
                        context.router.push(FintechHomeRoute());
                      } else {
                        setState(() {
                          screenMode = _TransferScreenMode.contacts;
                        });
                      }
                    },
                    title: 'Transfer',
                  ),
                ),
                SizedBox(height: 16),

                screenMode == _TransferScreenMode.contacts
                    ? _getContacts()
                    : _getTrasnferForm(context),
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
                    prefixIcon:
                        screenMode == _TransferScreenMode.contacts
                            ? BetterIcons.add01Outline
                            : null,
                    onPressed: () {
                      if (screenMode == _TransferScreenMode.contacts) {
                        setState(() {
                          screenMode = _TransferScreenMode.transferForm;
                        });
                      } else {
                        context.read<NavigatorCubit>().onNavigationItemTapped(
                          FintechTransferSuccessfullyRoute(),
                        );
                        context.router.replaceAll([
                          FintechTransferSuccessfullyRoute(),
                        ]);
                      }
                    },
                    text:
                        screenMode == _TransferScreenMode.contacts
                            ? 'New Transfer'
                            : 'Transfer',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTrasnferForm(BuildContext context) => Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    SizedBox(height: 12),
                    Row(
                      spacing: 8,
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.one,
                          size: AvatarSize.size40px,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              'Sara Brooks',
                              style: context.textTheme.labelLarge,
                            ),
                            Text(
                              '616-527-1341',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppDivider(height: 36),
                    Text(
                      'Send To',
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    SizedBox(height: 12),
                    Row(
                      spacing: 8,
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.two,
                          size: AvatarSize.size40px,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              'Kevin Yates',
                              style: context.textTheme.labelLarge,
                            ),
                            Text(
                              '801-846-5371',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: AppOutlinedButton(
                            onPressed: () {},
                            text: 'Change Audience',
                            color: SemanticColor.neutral,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Amount', style: context.textTheme.titleSmall),
                    SizedBox(height: 16),
                    AppTextField(
                      isFilled: false,
                      prefixIcon: Icon(
                        BetterIcons.dollarCircleOutline,
                        size: 20,
                        color: context.colors.onSurfaceVariant,
                      ),
                      hint: 'Custom Amount',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        amounts.length,
                        (index) => SizedBox(
                          width: 104,
                          child: AppBorderedToggleButton(
                            label: amounts[index],
                            isSelected: amounts[index] == selectedAmount,
                            onPressed: () {
                              setState(() {
                                if (amounts[index] == selectedAmount) {
                                  selectedAmount = null;
                                } else {
                                  selectedAmount = amounts[index];
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    AppTextField(
                      isFilled: false,
                      label: 'Note',
                      labelHelpText: '(Optional)',
                      hint: 'Enter Note',
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _getContacts() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: <Widget>[
            AppTextField(
              prefixIcon: Icon(
                BetterIcons.search01Filled,
                size: 20,
                color: context.colors.onSurfaceVariant,
              ),
              hint: 'Search',
            ),
            Text('Recent Transfer', style: context.textTheme.titleSmall),
          ],
        ),
      ),

      SizedBox(height: 16),

      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.one,
                  size: AvatarSize.size48px,
                ),
                Text('Lorri', style: context.textTheme.labelMedium),
              ],
            ),
            Column(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.two,
                  size: AvatarSize.size48px,
                ),
                Text('Kara', style: context.textTheme.labelMedium),
              ],
            ),
            Column(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.three,
                  size: AvatarSize.size48px,
                ),
                Text('Richard', style: context.textTheme.labelMedium),
              ],
            ),
            Column(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.four,
                  size: AvatarSize.size48px,
                ),
                Text('Maurice', style: context.textTheme.labelMedium),
              ],
            ),
            Column(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.five,
                  size: AvatarSize.size48px,
                ),
                Text('Gary', style: context.textTheme.labelMedium),
              ],
            ),
            Column(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.six,
                  size: AvatarSize.size48px,
                ),
                Text('Lillie', style: context.textTheme.labelMedium),
              ],
            ),
            Column(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.seven,
                  size: AvatarSize.size48px,
                ),
                Text('John', style: context.textTheme.labelMedium),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 24),

      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('John', style: context.textTheme.titleMedium),
            SizedBox(height: 16),

            ...contacts
                .map(
                  (e) => Row(
                    spacing: 8,
                    children: [
                      AppAvatar(
                        imageUrl: e.imageUrl,
                        size: AvatarSize.size40px,
                      ),
                      Column(
                        spacing: 4,
                        children: [
                          Text(e.name, style: context.textTheme.labelLarge),
                          Text(e.phone, style: context.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                )
                .toList()
                .separated(separator: AppDivider(height: 36)),
          ],
        ),
      ),
    ],
  );
}

class _Contact {
  final String imageUrl;
  final String name;
  final String phone;

  _Contact({required this.imageUrl, required this.name, required this.phone});
}
