import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_detail/presentation/blocs/shop_category_detail.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ShopCategoryDetailScreen extends StatelessWidget {
  final String? shopCategoryId;

  const ShopCategoryDetailScreen({
    super.key,
    @QueryParam("shopCategoryId") required this.shopCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopCategoryDetailBloc()..onStarted(id: shopCategoryId),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding,
        child: BlocConsumer<ShopCategoryDetailBloc, ShopCategoryDetailState>(
          listener: (context, state) {
            if (state.submitState.isLoaded) {
              context.showToast(
                context.tr.savedSuccessfully,
                type: SemanticColor.success,
              );
              context.router.back();
            }
          },
          builder: (context, state) {
            return switch (state.shopCategoryState) {
              ApiResponseInitial() => const SizedBox(),
              ApiResponseLoading() => const Center(
                child: CupertinoActivityIndicator(),
              ),
              ApiResponseError(:final message) => Center(child: Text(message)),
              ApiResponseLoaded() => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageHeader(
                    title: context.tr.shopCategory,
                    subtitle: context.tr.enterShopCategoryInformation,
                    showBackButton: true,
                    actions: [
                      if (state.shopCategoryId != null) ...[
                        AppOutlinedButton(
                          onPressed: context
                              .read<ShopCategoryDetailBloc>()
                              .onDelete,
                          color: SemanticColor.error,
                          isDisabled: state.submitState.isLoading,
                          prefixIcon: BetterIcons.delete03Outline,
                          text: context.tr.delete,
                        ),
                        if (state.status == Enum$ShopCategoryStatus.Disabled)
                          AppOutlinedButton(
                            onPressed: () => context
                                .read<ShopCategoryDetailBloc>()
                                .onDisable(),
                            isDisabled: state.submitState.isLoading,
                            text: context.tr.hide,
                            prefixIcon: BetterIcons.viewOffSlashFilled,
                          ),
                        if (state.status == Enum$ShopCategoryStatus.Enabled)
                          AppOutlinedButton(
                            onPressed: () => context
                                .read<ShopCategoryDetailBloc>()
                                .onEnable(),
                            isDisabled: state.submitState.isLoading,
                            text: context.tr.show,
                            prefixIcon: BetterIcons.eyeFilled,
                          ),
                      ],
                      AppFilledButton(
                        onPressed: context
                            .read<ShopCategoryDetailBloc>()
                            .onSubmit,
                        isDisabled: state.submitState.isLoading,
                        text: context.tr.saveChanges,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            AppTextField(
                              label: context.tr.name,
                              initialValue: state.name,
                              validator: context.validateName,
                              onChanged: context
                                  .read<ShopCategoryDetailBloc>()
                                  .onNameChanged,
                            ),
                            UploadFieldSmall(
                              title: context.tr.uploadImage,
                              initialValue: state.image,
                              onChanged: context
                                  .read<ShopCategoryDetailBloc>()
                                  .onImageChanged,
                            ),
                          ],
                        ),
                      ),
                      if (context.isDesktop) const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}
