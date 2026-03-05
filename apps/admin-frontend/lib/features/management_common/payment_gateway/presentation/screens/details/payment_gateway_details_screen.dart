import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:better_design_system/molecules/popup_menu_button/popup_menu_button.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/enums/payment_gateway_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/presentation/blocs/payment_gateway_details.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class PaymentGatewayDetailsScreen extends StatefulWidget {
  final String? paymentGatewayId;

  const PaymentGatewayDetailsScreen({super.key, this.paymentGatewayId});

  @override
  State<PaymentGatewayDetailsScreen> createState() =>
      _PaymentGatewayDetailsScreenState();
}

class _PaymentGatewayDetailsScreenState
    extends State<PaymentGatewayDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaymentGatewayDetailsBloc()..onStarted(id: widget.paymentGatewayId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child:
            BlocConsumer<PaymentGatewayDetailsBloc, PaymentGatewayDetailsState>(
              listener: (context, state) {
                if (state.networkStateSave.isLoaded) {
                  context.router.back();
                }
                if (state.networkStateSave.isError) {
                  context.showToast(
                    state.networkStateSave.errorMessage ?? "Error",
                    type: SemanticColor.error,
                  );
                }
              },
              builder: (context, state) {
                final apiKeyFields = _buildApiKeysFields(context, state);
                return AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: switch (state.paymentGateway) {
                    ApiResponseInitial() => const SizedBox(),
                    ApiResponseLoading() => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    ApiResponseError(:final message) => Center(
                      child: Text(message.toString()),
                    ),
                    ApiResponseLoaded() => Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PageHeader(
                            title: context.tr.paymentGateway,
                            subtitle: context.tr.paymentGatewaySubtitle,
                            showBackButton: true,
                            actions: [
                              if (state.isEnabled &&
                                  widget.paymentGatewayId != null)
                                AppOutlinedButton(
                                  onPressed: () {
                                    context
                                        .read<PaymentGatewayDetailsBloc>()
                                        .onHide();
                                  },
                                  text: context.tr.hide,
                                  prefixIcon: BetterIcons.viewOffSlashFilled,
                                  color: SemanticColor.neutral,
                                ),
                              if (!state.isEnabled &&
                                  widget.paymentGatewayId != null)
                                AppOutlinedButton(
                                  onPressed: () {
                                    context
                                        .read<PaymentGatewayDetailsBloc>()
                                        .onShow();
                                  },
                                  text: context.tr.show,
                                  prefixIcon: BetterIcons.eyeFilled,
                                  color: SemanticColor.neutral,
                                ),
                              // AppFilledButton(
                              //   text: "Set as Default",
                              //   onPressed: () {
                              //     bloc.onSetAsDefault();
                              //   },
                              // ),
                              AppFilledButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context
                                      .read<PaymentGatewayDetailsBloc>()
                                      .onSave();
                                },
                                text: context.tr.saveChanges,
                              ),
                              if (widget.paymentGatewayId != null)
                                AppPopupMenuButton(
                                  items: [
                                    AppPopupMenuItem(
                                      title: context.tr.delete,
                                      onPressed: context
                                          .read<PaymentGatewayDetailsBloc>()
                                          .onDelete,
                                      icon: BetterIcons.delete03Outline,
                                      color: SemanticColor.error,
                                    ),
                                  ],
                                  childBuilder: (onPressed) => AppIconButton(
                                    icon:
                                        BetterIcons.moreVerticalCircle01Filled,
                                    onPressed: onPressed,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          UploadFieldSmall(
                            title: context.tr.uploadImage,
                            onChanged: context
                                .read<PaymentGatewayDetailsBloc>()
                                .onImageChanged,
                            initialValue: state.media,
                          ),
                          const SizedBox(height: 16),
                          AlignedGridView.count(
                            shrinkWrap: true,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            itemCount: 2,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return switch (index) {
                                0 => AppTextField(
                                  label: context.tr.title,
                                  initialValue: state.name,
                                  onChanged: context
                                      .read<PaymentGatewayDetailsBloc>()
                                      .onNameChanged,
                                ),
                                1 => AppDropdownField.single(
                                  initialValue: state.type,
                                  label: context.tr.type,
                                  onChanged: (p0) {
                                    context
                                        .read<PaymentGatewayDetailsBloc>()
                                        .onTypeChanged(p0);
                                  },
                                  items: Enum$PaymentGatewayType.values
                                      .map(
                                        (e) => AppDropdownItem(
                                          title: e.name(context),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                ),
                                _ => const Text("Not implemented"),
                              };
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "API Keys",
                            style: context.textTheme.bodyMedium?.variant(
                              context,
                            ),
                          ),
                          const SizedBox(height: 16),
                          AlignedGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            itemCount: state.type?.apiKeys(context).length ?? 0,
                            itemBuilder: (context, index) {
                              return switch (index) {
                                0 => apiKeyFields.elementAtOrNull(0),
                                1 => apiKeyFields.elementAtOrNull(1),
                                2 => apiKeyFields.elementAtOrNull(2),
                                3 => apiKeyFields.elementAtOrNull(3),
                                _ => const Text("Not implemented"),
                              };
                            },
                          ),
                        ],
                      ),
                    ),
                  },
                );
              },
            ),
      ),
    );
  }

  List<Widget> _buildApiKeysFields(
    BuildContext context,
    PaymentGatewayDetailsState state,
  ) {
    if (state.type == null) return [];
    final apiKeyFields = state.type!.apiKeys(context);
    return [
      AppTextField(
        label: apiKeyFields.privateKey,
        initialValue: state.privateKey,
        onChanged: context
            .read<PaymentGatewayDetailsBloc>()
            .onPrivateKeyChanged,
      ),
      if (apiKeyFields.publicKey != null)
        AppTextField(
          label: apiKeyFields.publicKey,
          initialValue: state.publicKey,
          onChanged: context
              .read<PaymentGatewayDetailsBloc>()
              .onPublicKeyChanged,
        ),
      if (apiKeyFields.merchantId != null)
        AppTextField(
          label: apiKeyFields.merchantId,
          initialValue: state.merchantId,
          onChanged: context
              .read<PaymentGatewayDetailsBloc>()
              .onMerchantIdChanged,
        ),
      if (apiKeyFields.saltKey != null)
        AppTextField(
          label: apiKeyFields.saltKey,
          initialValue: state.saltKey,
          onChanged: context.read<PaymentGatewayDetailsBloc>().onSaltKeyChanged,
        ),
    ];
  }
}
