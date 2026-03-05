import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_upsert_item_dialog.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailUpsertItemDialog extends StatelessWidget {
  final String shopId;
  final String? itemId;

  const ShopDetailUpsertItemDialog({
    super.key,
    required this.shopId,
    this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopDetailUpsertItemDialogBloc()
            ..onStarted(shopId: shopId, itemId: itemId),
      child:
          BlocConsumer<
            ShopDetailUpsertItemDialogBloc,
            ShopDetailUpsertItemDialogState
          >(
            listener: (context, state) {
              if (state.submitState.isLoaded) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return AppResponsiveDialog(
                icon: BetterIcons.addCircleFilled,
                title: itemId == null
                    ? context.tr.createItem
                    : context.tr.updateItem,
                subtitle: context.tr.enterInformationOfItem,
                maxWidth: 700,
                secondaryButton: AppOutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  text: context.tr.cancel,
                ),
                primaryButton: AppFilledButton(
                  text: context.tr.saveChanges,
                  onPressed: () {
                    context.read<ShopDetailUpsertItemDialogBloc>().onSubmit();
                  },
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeHeader(title: context.tr.image),
                      const SizedBox(height: 16),
                      UploadFieldSmall(
                        onChanged: context
                            .read<ShopDetailUpsertItemDialogBloc>()
                            .onImageChanged,
                        initialValue: state.image,
                      ),
                      const SizedBox(height: 24),
                      LargeHeader(title: context.tr.information),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: context.tr.name,
                        hint: context.tr.enterName,
                        initialValue: state.name,
                        onChanged: context
                            .read<ShopDetailUpsertItemDialogBloc>()
                            .onNameChanged,
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<
                        ShopDetailUpsertItemDialogBloc,
                        ShopDetailUpsertItemDialogState
                      >(
                        builder: (context, state) {
                          return switch (state.categoriesState) {
                            ApiResponseLoaded(:final data) => AppDropdownField(
                              label: context.tr.categories,
                              initialValue: state.selectedCategories,
                              hint: context.tr.selectCategories,
                              isMultiSelect: true,
                              onMultiChanged: context
                                  .read<ShopDetailUpsertItemDialogBloc>()
                                  .onCategoriesChanged,
                              items: data
                                  .map(
                                    (e) => AppDropdownItem(
                                      title: e.name,
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                            ),
                            _ => const SizedBox(),
                          };
                        },
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<
                        ShopDetailUpsertItemDialogBloc,
                        ShopDetailUpsertItemDialogState
                      >(
                        builder: (context, state) {
                          return switch (state.presetsState) {
                            ApiResponseLoaded(:final data) => AppDropdownField(
                              label: context.tr.presets,
                              initialValue: state.selectedPresets,
                              isMultiSelect: true,
                              hint: context.tr.selectPresets,
                              onMultiChanged: context
                                  .read<ShopDetailUpsertItemDialogBloc>()
                                  .onPresetsChanged,
                              items: data
                                  .map(
                                    (e) => AppDropdownItem(
                                      title: e.name,
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                            ),
                            _ => const SizedBox(),
                          };
                        },
                      ),
                      const SizedBox(height: 24),
                      LargeHeader(
                        title: context.tr.variants,
                        actions: [
                          AppTextButton(
                            text: context.tr.addNew,
                            prefixIcon: BetterIcons.addCircleOutline,
                            onPressed: context
                                .read<ShopDetailUpsertItemDialogBloc>()
                                .addVariant,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<
                        ShopDetailUpsertItemDialogBloc,
                        ShopDetailUpsertItemDialogState
                      >(
                        builder: (context, state) {
                          return Column(
                            children: state.variants
                                .mapIndexed((index, variant) {
                                  if (variant == null) return null;
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: AppTextField(
                                          label: context.tr.name,
                                          hint: context.tr.enterName,
                                          initialValue: variant.name,
                                          onChanged: (p0) => context
                                              .read<
                                                ShopDetailUpsertItemDialogBloc
                                              >()
                                              .onVariantNameChanged(index, p0),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppNumberField(
                                          title: context.tr.price,
                                          hint: context.tr.enterPrice,
                                          initialValue: variant.price,
                                          onChanged: (p0) => context
                                              .read<
                                                ShopDetailUpsertItemDialogBloc
                                              >()
                                              .onVariantPriceChanged(index, p0),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 32),
                                        child: AppTextButton(
                                          text: null,
                                          prefixIcon:
                                              BetterIcons.cancel01Outline,
                                          color: SemanticColor.error,
                                          onPressed: () => context
                                              .read<
                                                ShopDetailUpsertItemDialogBloc
                                              >()
                                              .removeVariant(index),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                                .nonNulls
                                .toList()
                                .separated(
                                  separator: const SizedBox(height: 16),
                                ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      LargeHeader(
                        title: context.tr.options,
                        actions: [
                          AppTextButton(
                            text: context.tr.addNew,
                            prefixIcon: BetterIcons.addCircleOutline,
                            onPressed: () {
                              context
                                  .read<ShopDetailUpsertItemDialogBloc>()
                                  .addOption();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<
                        ShopDetailUpsertItemDialogBloc,
                        ShopDetailUpsertItemDialogState
                      >(
                        builder: (context, state) {
                          return Column(
                            children: state.options
                                .mapIndexed((index, option) {
                                  if (option == null) return null;
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: AppTextField(
                                          label: context.tr.name,
                                          hint: context.tr.enterName,
                                          initialValue: option.name,
                                          onChanged: (p0) => context
                                              .read<
                                                ShopDetailUpsertItemDialogBloc
                                              >()
                                              .onOptionNameChanged(index, p0),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppNumberField(
                                          title: context.tr.price,
                                          hint: context.tr.enterPrice,
                                          initialValue: option.price,
                                          onChanged: (p0) => context
                                              .read<
                                                ShopDetailUpsertItemDialogBloc
                                              >()
                                              .onOptionPriceChanged(index, p0),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 32),
                                        child: AppTextButton(
                                          text: null,
                                          prefixIcon:
                                              BetterIcons.cancel01Outline,
                                          color: SemanticColor.error,
                                          onPressed: () => context
                                              .read<
                                                ShopDetailUpsertItemDialogBloc
                                              >()
                                              .removeOption(index),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                                .nonNulls
                                .toList()
                                .separated(
                                  separator: const SizedBox(height: 16),
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
