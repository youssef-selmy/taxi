// ignore_for_file: use_build_context_synchronously

import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/config/country_data.dart';
import 'package:better_design_system/entities/payment_processor.entity.dart';
import 'package:better_design_system/entities/payment_processor_link_intent_result.entity.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef BetterAddPaymentMethodDialogTemplate =
    AppAddPaymentMethodDialogTemplate;

class AppAddPaymentMethodDialogTemplate extends StatefulWidget {
  final Function() onMobileBackPressed;
  final ApiResponse<List<PaymentProcessorEntity>> paymentProcessorsResponse;
  final Future<ApiResponse<PaymentProcessorLinkIntentResultEntity>> Function(
    PaymentProcessorEntity,
  )
  paymentProcessorsCallback;

  const AppAddPaymentMethodDialogTemplate({
    super.key,
    required this.onMobileBackPressed,
    required this.paymentProcessorsResponse,
    required this.paymentProcessorsCallback,
  });

  @override
  State<AppAddPaymentMethodDialogTemplate> createState() =>
      _AppAddPaymentMethodDialogTemplateState();
}

class _AppAddPaymentMethodDialogTemplateState
    extends State<AppAddPaymentMethodDialogTemplate> {
  PaymentProcessorEntity? selectedPaymentGateway;
  String? cardNumber;
  CountryInfo? country;
  String? zipCode;
  String? cardHolderName;
  String? cvv;

  @override
  void didUpdateWidget(covariant AppAddPaymentMethodDialogTemplate oldWidget) {
    if (oldWidget.paymentProcessorsResponse !=
        widget.paymentProcessorsResponse) {
      setState(() {
        selectedPaymentGateway =
            widget.paymentProcessorsResponse.data?.firstOrNull;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    selectedPaymentGateway = widget.paymentProcessorsResponse.data?.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.isDesktop;
    return AppResponsiveDialog(
      defaultDialogType: DialogType.fullScreenBottomSheet,
      desktopDialogType: DialogType.dialog,
      maxWidth: 800,
      title: context.strings.addPaymentMethod,
      icon: BetterIcons.link04Filled,
      primaryButton: AppFilledButton(
        isDisabled: selectedPaymentGateway == null,
        text: context.strings.submit,
        onPressed: () async {
          if (selectedPaymentGateway == null) {
            context.showToast(context.strings.selectPaymentMethod);
            return;
          }
          final paymentProcessor = selectedPaymentGateway!;
          final result = await widget.paymentProcessorsCallback(
            paymentProcessor,
          );
          if (result.isError) {
            context.showToast(
              result.errorMessage ?? 'Error',
              type: SemanticColor.error,
            );
            return;
          }
          Navigator.of(context).pop(result.data);
        },
      ),
      secondaryButton: AppOutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: context.strings.cancel,
      ),
      onClosePressed: () => Navigator.of(context).pop(),
      child: LayoutGrid(
        columnSizes: context.isDesktop ? [1.fr, 1.fr] : [1.fr],
        rowSizes: isDesktop ? [auto] : [auto, auto],
        rowGap: 16,
        columnGap: 16,
        children: [
          switch (widget.paymentProcessorsResponse) {
            ApiResponseInitial() => const SizedBox(),
            ApiResponseLoading() => Column(
              spacing: 16,
              children: [
                for (int i = 0; i < 3; i++) ...[
                  const Skeletonizer(
                    enabled: true,
                    child: AppListItem(
                      icon: BetterIcons.creditCardFilled,
                      title: '----------------',
                    ),
                  ),
                ],
              ],
            ),
            ApiResponseLoaded(:final data) => Column(
              spacing: 16,
              children: [
                for (final paymentGateway in data) ...[
                  AppListItem(
                    icon: paymentGateway.logoUrl == null
                        ? BetterIcons.creditCardFilled
                        : null,
                    leading: paymentGateway.logoUrl == null
                        ? null
                        : CachedNetworkImage(
                            imageUrl: paymentGateway.logoUrl!,
                            width: 20,
                            height: 20,
                            errorWidget: (context, url, error) => Icon(
                              BetterIcons.alert02Filled,
                              size: 20,
                              color: context.colors.onSurfaceVariantLow,
                            ),
                          ),
                    title: paymentGateway.name,
                    actionType: ListItemActionType.radio,
                    onTap: (value) {
                      setState(() {
                        selectedPaymentGateway = value ? paymentGateway : null;
                      });
                    },
                    isSelected: selectedPaymentGateway?.id == paymentGateway.id,
                  ),
                ],
              ],
            ),
            ApiResponseError(:final message) => AppEmptyState(
              title: message,
              image: Assets.images.emptyStates.error,
            ),
          },
          _buildPaymentGatewayIntegration(selectedPaymentGateway?.linkMethod),
        ],
      ),
    );
  }

  dynamic _buildPaymentGatewayIntegration(
    PaymentProcessorLinkMethod? linkMethod,
  ) {
    switch (linkMethod) {
      case PaymentProcessorLinkMethod.manual:
        return _buildManualPaymentGatewayInputForm();
      case PaymentProcessorLinkMethod.redirect:
        return _buildRedirectPaymentGatewayIntegration();
      case null:
        return const SizedBox();
      case PaymentProcessorLinkMethod.none:
        return const SizedBox();
    }
  }

  Column _buildManualPaymentGatewayInputForm() {
    final allCountries = getAllCountries();
    return Column(
      spacing: 16,
      children: [
        AppTextField(
          label: context.strings.cardNumber,
          initialValue: cardNumber,
          onChanged: (value) {
            setState(() {
              cardNumber = value;
            });
          },
          hint: 'Enter card number',
        ),
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: AppTextField(
                initialValue: cardNumber,
                onChanged: (value) => setState(() => cardNumber = value),
                label: context.strings.expiryDate,
                hint: 'MM/YY',
              ),
            ),
            Expanded(
              child: AppTextField(
                onChanged: (value) => setState(() => cardNumber = value),
                initialValue: cvv,
                label: context.strings.cvv,
                hint: 'Enter CVV',
              ),
            ),
          ],
        ),
        AppDropdownField<CountryInfo>.single(
          label: context.strings.country,
          initialValue: country,
          onChanged: (value) {
            setState(() {
              country = value;
            });
          },
          hint: 'Select country',
          items: allCountries
              .map((e) => AppDropdownItem(value: e, title: e.name))
              .toList(),
        ),
        AppTextField(
          label: context.strings.zipCode,
          initialValue: zipCode,
          onChanged: (value) => setState(() => zipCode = value),
          hint: context.strings.zipCodeHint,
        ),
        AppTextField(
          label: context.strings.accountHolderName,
          initialValue: cardHolderName,
          onChanged: (value) => setState(() => cardHolderName = value),
          hint: 'Enter card holder name',
        ),
      ],
    );
  }

  Column _buildRedirectPaymentGatewayIntegration() {
    return const Column(
      spacing: 16,
      children: [
        Text(
          'You will be redirected to the payment gateway to complete the process.',
        ),
      ],
    );
  }
}
