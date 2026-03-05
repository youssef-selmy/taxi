import 'package:better_design_system/atoms/buttons/icon_button.dart';
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
import 'package:admin_frontend/core/enums/email_provider_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/email_provider/presentation/blocs/email_provider_details.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class EmailProviderDetailsScreen extends StatelessWidget {
  final String? emailProviderId;

  EmailProviderDetailsScreen({
    super.key,
    @PathParam('emailProviderId') this.emailProviderId,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmailProviderDetailsBloc()..onStarted(id: emailProviderId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            BlocBuilder<EmailProviderDetailsBloc, EmailProviderDetailsState>(
              builder: (context, state) {
                return PageHeader(
                  title: emailProviderId == null
                      ? context.tr.emailProviderCreate
                      : context.tr.emailProviderUpdate,
                  subtitle: emailProviderId == null
                      ? context.tr.emailProviderCreateSubtitle
                      : context.tr.emailProviderUpdateSubtitle,
                  showBackButton: true,
                  actions: [
                    if (!state.isDefault && emailProviderId != null)
                      AppOutlinedButton(
                        onPressed: () {
                          context
                              .read<EmailProviderDetailsBloc>()
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
                        context.read<EmailProviderDetailsBloc>().onSave();
                      },
                      text: context.tr.saveChanges,
                    ),
                    AppPopupMenuButton(
                      showArrow: false,
                      items: [
                        AppPopupMenuItem(
                          title: context.tr.delete,
                          onPressed: () {
                            context.read<EmailProviderDetailsBloc>().onDelete();
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
              child:
                  BlocConsumer<
                    EmailProviderDetailsBloc,
                    EmailProviderDetailsState
                  >(
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
                          switch (state.emailProvider) {
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                              .read<EmailProviderDetailsBloc>()
                                              .onNameChanged,
                                        ),
                                        1 =>
                                          AppDropdownField<
                                            Enum$EmailProviderType
                                          >.single(
                                            label: context.tr.type,
                                            initialValue: state.type,
                                            isRequired: true,
                                            onChanged: context
                                                .read<
                                                  EmailProviderDetailsBloc
                                                >()
                                                .onTypeChanged,
                                            items:
                                                [
                                                      Enum$EmailProviderType
                                                          .SendGrid,
                                                      Enum$EmailProviderType
                                                          .MailerSend,
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
                                    style: context.textTheme.bodyMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 16),
                                  AlignedGridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                        _ => const Text("Not implemented"),
                                      };
                                    },
                                  ),
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
    EmailProviderDetailsState state,
  ) {
    final apiKeyFields = state.type?.apiKeys(context);
    if (apiKeyFields == null) {
      return [];
    }
    return [
      if (apiKeyFields.apiKey != null)
        AppTextField(
          label: apiKeyFields.apiKey,
          initialValue: state.apiKey,
          isRequired: true,
          onChanged: context.read<EmailProviderDetailsBloc>().onApiKeyChanged,
        ),
      if (apiKeyFields.fromEmail != null)
        AppTextField(
          label: apiKeyFields.fromEmail,
          initialValue: state.fromEmail,
          isRequired: true,
          onChanged: context
              .read<EmailProviderDetailsBloc>()
              .onFromEmailChanged,
        ),
      if (apiKeyFields.fromName != null)
        AppTextField(
          label: apiKeyFields.fromName,
          initialValue: state.fromName,
          isRequired: false,
          onChanged: context.read<EmailProviderDetailsBloc>().onFromNameChanged,
        ),
      if (apiKeyFields.replyToEmail != null)
        AppTextField(
          label: apiKeyFields.replyToEmail,
          initialValue: state.replyToEmail,
          isRequired: false,
          onChanged: context
              .read<EmailProviderDetailsBloc>()
              .onReplyToEmailChanged,
        ),
    ];
  }
}
