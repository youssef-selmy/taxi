import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_create_category_dialog.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailUpsertCategoryDialog extends StatelessWidget {
  final String shopId;
  final String? categoryId;

  const ShopDetailUpsertCategoryDialog({
    super.key,
    required this.shopId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopDetailCreateCategoryDialogBloc()
            ..onStarted(shopId: shopId, categoryId: categoryId),
      child:
          BlocConsumer<
            ShopDetailCreateCategoryDialogBloc,
            ShopDetailCreateCategoryDialogState
          >(
            listener: (context, state) {
              if (state.submitState.isLoaded) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return AppResponsiveDialog(
                icon: BetterIcons.addCircleFilled,
                title: categoryId == null
                    ? context.tr.createCategory
                    : context.tr.updateCategory,
                subtitle: context.tr.enterInformationOfCategory,
                maxWidth: 700,
                secondaryButton: AppOutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  text: context.tr.cancel,
                ),
                primaryButton: AppFilledButton(
                  text: context.tr.saveChanges,
                  onPressed: () => context
                      .read<ShopDetailCreateCategoryDialogBloc>()
                      .onSubmit(),
                ),
                child: Column(
                  children: [
                    UploadFieldSmall(
                      onChanged: context
                          .read<ShopDetailCreateCategoryDialogBloc>()
                          .onImageChanged,
                      initialValue: state.image,
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      label: context.tr.name,
                      hint: context.tr.enterName,
                      initialValue: state.name,
                      onChanged: context
                          .read<ShopDetailCreateCategoryDialogBloc>()
                          .onNameChanged,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<
                      ShopDetailCreateCategoryDialogBloc,
                      ShopDetailCreateCategoryDialogState
                    >(
                      builder: (context, state) {
                        return switch (state.presetsState) {
                          ApiResponseLoaded(:final data) =>
                            AppDropdownField.multi(
                              label: context.tr.presets,
                              initialValue: state.selectedPresets,
                              onChanged: context
                                  .read<ShopDetailCreateCategoryDialogBloc>()
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
                  ],
                ),
              );
            },
          ),
    );
  }
}
