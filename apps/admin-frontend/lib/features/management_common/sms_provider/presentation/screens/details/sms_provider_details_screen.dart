import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:better_design_system/molecules/popup_menu_button/popup_menu_button.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/sms_provider_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/sms_provider/presentation/blocs/sms_provider_details.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class SmsProviderDetailsScreen extends StatelessWidget {
  final String? smsProviderId;

  SmsProviderDetailsScreen({
    super.key,
    @PathParam('smsProviderId') this.smsProviderId,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SmsProviderDetailsBloc()..onStarted(id: smsProviderId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            BlocBuilder<SmsProviderDetailsBloc, SmsProviderDetailsState>(
              builder: (context, state) {
                return PageHeader(
                  title: smsProviderId == null
                      ? context.tr.smsProviderCreate
                      : context.tr.smsProviderUpdate,
                  subtitle: smsProviderId == null
                      ? context.tr.smsProviderCreateSubtitle
                      : context.tr.smsProviderUpdateSubtitle,
                  showBackButton: true,
                  actions: [
                    if (!state.isDefault && smsProviderId != null)
                      AppOutlinedButton(
                        onPressed: () {
                          context
                              .read<SmsProviderDetailsBloc>()
                              .onSetAsDefault();
                        },
                        isDisabled:
                            state.networkStateSave.isLoading ||
                            state.networkStateSetDefault.isLoading,
                        text: context.tr.setAsDefault,
                        prefixIcon: BetterIcons.tick02Filled,
                        color: SemanticColor.neutral,
                      ),
                    AppFilledButton(
                      isDisabled: state.networkStateSave.isLoading,
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        context.read<SmsProviderDetailsBloc>().onSave();
                      },
                      text: context.tr.saveChanges,
                    ),
                    AppPopupMenuButton(
                      showArrow: false,
                      items: [
                        AppPopupMenuItem(
                          title: context.tr.delete,
                          onPressed: () {
                            context.read<SmsProviderDetailsBloc>().onDelete();
                          },
                          icon: BetterIcons.delete03Outline,
                          color: SemanticColor.error,
                        ),
                      ],
                      childBuilder: (onPressed) => AppIconButton(
                        icon: BetterIcons.moreVerticalCircle01Filled,
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocConsumer<SmsProviderDetailsBloc, SmsProviderDetailsState>(
                listener: (context, state) {
                  if (state.networkStateSave.isLoaded) {
                    context.router.back();
                  }
                },
                builder: (context, state) {
                  final apiKeysTitles = state.type?.apiKeys(context);
                  final apiKeyFields = state.type != null
                      ? _buildApiKeysFields(context, state)
                      : [];
                  return Column(
                    children: [
                      switch (state.smsProvider) {
                        ApiResponseInitial() => const SizedBox(),
                        ApiResponseLoading() =>
                          const CircularProgressIndicator(),
                        ApiResponseError(:final message) => Text(message),
                        ApiResponseLoaded() => Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AlignedGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
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
                                      isRequired: true,
                                      onChanged: context
                                          .read<SmsProviderDetailsBloc>()
                                          .onNameChanged,
                                    ),
                                    1 =>
                                      AppDropdownField<
                                        Enum$SMSProviderType
                                      >.single(
                                        label: context.tr.type,
                                        initialValue: state.type,
                                        isRequired: true,
                                        onChanged: context
                                            .read<SmsProviderDetailsBloc>()
                                            .onTypeChanged,
                                        items:
                                            [
                                                  Enum$SMSProviderType.Twilio,
                                                  Enum$SMSProviderType.Vonage,
                                                  Enum$SMSProviderType.Plivo,
                                                  Enum$SMSProviderType.Pahappa,
                                                  Enum$SMSProviderType.BroadNet,
                                                  Enum$SMSProviderType
                                                      .ClickSMSNet,
                                                ]
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                itemCount: apiKeysTitles?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return switch (index) {
                                    0 => apiKeyFields.elementAtOrNull(0),
                                    1 => apiKeyFields.elementAtOrNull(1),
                                    2 => apiKeyFields.elementAtOrNull(2),
                                    3 => apiKeyFields.elementAtOrNull(3),
                                    4 => apiKeyFields.elementAtOrNull(4),
                                    _ => const Text("Not implemented"),
                                  };
                                },
                              ),
                              if (apiKeysTitles?.showCallMasking ?? false) ...[
                                const SizedBox(height: 24),
                                Text(
                                  "Call Masking",
                                  style: context.textTheme.bodyMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AlignedGridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  itemCount: 2,
                                  itemBuilder: (context, index) => switch (index) {
                                    0 => Row(
                                      children: [
                                        AppSwitch(
                                          isSelected: state.callMaskingEnabled,
                                          onChanged: context
                                              .read<SmsProviderDetailsBloc>()
                                              .onCallMaskingEnabledChanged,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          "Enable Call Masking",
                                          style: context.textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                    1 => AppTextField(
                                      label: "Masking Phone Number",
                                      initialValue: state.callMaskingNumber,
                                      isRequired: false,
                                      labelHelpText:
                                          "Twilio phone number used for call masking (e.g., +1234567890)",
                                      onChanged: context
                                          .read<SmsProviderDetailsBloc>()
                                          .onCallMaskingNumberChanged,
                                    ),
                                    _ => const SizedBox(),
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      },
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildApiKeysFields(
    BuildContext context,
    SmsProviderDetailsState state,
  ) {
    final apiKeyFields = state.type?.apiKeys(context);
    if (apiKeyFields == null) {
      return [];
    }
    return [
      if (apiKeyFields.accountId != null)
        AppTextField(
          label: apiKeyFields.accountId,
          initialValue: state.accountId,
          isRequired: true,
          onChanged: context.read<SmsProviderDetailsBloc>().onAccountIdChanged,
        ),
      if (apiKeyFields.authToken != null)
        AppTextField(
          label: apiKeyFields.authToken,
          initialValue: state.authToken,
          isRequired: true,
          onChanged: context.read<SmsProviderDetailsBloc>().onAuthTokenChanged,
        ),
      if (apiKeyFields.fromNumber != null)
        AppTextField(
          label: apiKeyFields.fromNumber,
          initialValue: state.fromNumber,
          isRequired: true,
          onChanged: context.read<SmsProviderDetailsBloc>().onFromNumberChanged,
        ),
      if (apiKeyFields.smsType != null)
        AppTextField(
          label: apiKeyFields.smsType,
          initialValue: state.smsType,
          isRequired: true,
          onChanged: context.read<SmsProviderDetailsBloc>().onSmsTypeChanged,
        ),
      if (apiKeyFields.verificationTemplate != null)
        AppTextField(
          label: apiKeyFields.verificationTemplate,
          initialValue: state.verificationTemplate,
          isRequired: true,
          labelHelpText:
              "The template used for SMS verification. {code} as a placeholder will be replaced with the actual code. e.g. Your verification code is {code}",
          onChanged: context
              .read<SmsProviderDetailsBloc>()
              .onVerificationTemplateChanged,
        ),
    ];
  }
}
