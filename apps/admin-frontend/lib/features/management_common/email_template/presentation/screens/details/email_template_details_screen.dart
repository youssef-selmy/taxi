import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:better_design_system/molecules/popup_menu_button/popup_menu_button.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/email_content_source.dart';
import 'package:admin_frontend/core/enums/email_event_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/email_template/presentation/blocs/email_template_details.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class EmailTemplateDetailsScreen extends StatelessWidget {
  final String? emailTemplateId;

  EmailTemplateDetailsScreen({
    super.key,
    @PathParam('emailTemplateId') this.emailTemplateId,
  });

  final _formKey = GlobalKey<FormState>();

  String _getPlaceholdersForEventType(Enum$EmailEventType? eventType) {
    switch (eventType) {
      case Enum$EmailEventType.AUTH_VERIFICATION:
      case Enum$EmailEventType.AUTH_PASSWORD_RESET:
        return "Available placeholders: {firstName}, {email}, {verificationCode}";
      case Enum$EmailEventType.AUTH_WELCOME:
        return "Available placeholders: {firstName}, {lastName}, {email}";
      case Enum$EmailEventType.DRIVER_APPROVED:
        return "Available placeholders: {firstName}, {lastName}, {email}, {phone}, {vehicleModel}, {licensePlate}";
      case Enum$EmailEventType.DRIVER_REJECTED:
      case Enum$EmailEventType.DRIVER_DOCUMENTS_PENDING:
      case Enum$EmailEventType.DRIVER_SUSPENDED:
      case Enum$EmailEventType.DRIVER_REGISTRATION_SUBMITTED:
        return "Available placeholders: {firstName}, {lastName}, {email}, {phone}";
      case Enum$EmailEventType.ORDER_CONFIRMED:
      case Enum$EmailEventType.ORDER_COMPLETED:
        return "Available placeholders: {firstName}, {lastName}, {email}, {phone}, {orderNumber}, {amount}, {date}, {pickup}, {dropoff}, {driverName}, {vehicleModel}, {licensePlate}";
      case Enum$EmailEventType.ORDER_CANCELLED:
        return "Available placeholders: {firstName}, {lastName}, {email}, {orderNumber}";
      case Enum$EmailEventType.ORDER_REFUNDED:
        return "Available placeholders: {firstName}, {lastName}, {email}, {orderNumber}, {amount}";
      case Enum$EmailEventType.EXPIRING_KYC_30_DAY_REMINDER:
      case Enum$EmailEventType.EXPIRING_KYC_14_DAY_REMINDER:
      case Enum$EmailEventType.EXPIRING_KYC_7_DAY_REMINDER:
      case Enum$EmailEventType.EXPIRING_KYC_3_DAY_REMINDER:
      case Enum$EmailEventType.EXPIRING_KYC_2_DAY_REMINDER:
      case Enum$EmailEventType.EXPIRING_KYC_1_DAY_REMINDER:
        return "Available placeholders: {firstName}, {documentType}";
      default:
        return "Select an event type to see available placeholders";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmailTemplateDetailsBloc()..onStarted(id: emailTemplateId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            BlocBuilder<EmailTemplateDetailsBloc, EmailTemplateDetailsState>(
              builder: (context, state) {
                return PageHeader(
                  title: emailTemplateId == null
                      ? context.tr.emailTemplateCreate
                      : context.tr.emailTemplateUpdate,
                  subtitle: emailTemplateId == null
                      ? context.tr.emailTemplateCreateSubtitle
                      : context.tr.emailTemplateUpdateSubtitle,
                  showBackButton: true,
                  actions: [
                    AppFilledButton(
                      isDisabled: state.networkStateSave.isLoading,
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        context.read<EmailTemplateDetailsBloc>().onSave();
                      },
                      text: context.tr.saveChanges,
                    ),
                    AppPopupMenuButton(
                      showArrow: false,
                      items: [
                        AppPopupMenuItem(
                          title: context.tr.delete,
                          onPressed: () {
                            context.read<EmailTemplateDetailsBloc>().onDelete();
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
              child: SingleChildScrollView(
                child: BlocConsumer<EmailTemplateDetailsBloc, EmailTemplateDetailsState>(
                  listener: (context, state) {
                    if (state.networkStateSave.isLoaded) {
                      context.router.back();
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        switch (state.emailTemplate) {
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
                                  itemCount: 4,
                                  crossAxisCount: 2,
                                  itemBuilder: (context, index) {
                                    return switch (index) {
                                      0 => AppTextField(
                                        label: context.tr.name,
                                        initialValue: state.name,
                                        isRequired: true,
                                        onChanged: context
                                            .read<EmailTemplateDetailsBloc>()
                                            .onNameChanged,
                                      ),
                                      1 =>
                                        AppDropdownField<
                                          Enum$EmailEventType
                                        >.single(
                                          label: context.tr.eventType,
                                          initialValue: state.eventType,
                                          isRequired: true,
                                          onChanged: context
                                              .read<EmailTemplateDetailsBloc>()
                                              .onEventTypeChanged,
                                          items: Enum$EmailEventType.values
                                              .where(
                                                (e) =>
                                                    e !=
                                                    Enum$EmailEventType
                                                        .$unknown,
                                              )
                                              .map(
                                                (e) => AppDropdownItem(
                                                  title: e.name(context),
                                                  value: e,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      2 => AppTextField(
                                        label: "Locale",
                                        initialValue: state.locale,
                                        isRequired: false,
                                        labelHelpText:
                                            "Optional locale code (e.g., en, es, fr) for i18n support",
                                        onChanged: context
                                            .read<EmailTemplateDetailsBloc>()
                                            .onLocaleChanged,
                                      ),
                                      3 => Row(
                                        children: [
                                          AppSwitch(
                                            isSelected: state.isActive,
                                            onChanged: context
                                                .read<
                                                  EmailTemplateDetailsBloc
                                                >()
                                                .onIsActiveChanged,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            "Active",
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                      _ => const Text("Not implemented"),
                                    };
                                  },
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Email Content",
                                  style: context.textTheme.bodyMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AppDropdownField<
                                  Enum$EmailContentSource
                                >.single(
                                  label: "Content Source",
                                  initialValue: state.contentSource,
                                  isRequired: true,
                                  onChanged: context
                                      .read<EmailTemplateDetailsBloc>()
                                      .onContentSourceChanged,
                                  items: Enum$EmailContentSource.values
                                      .where(
                                        (e) =>
                                            e !=
                                            Enum$EmailContentSource.$unknown,
                                      )
                                      .map(
                                        (e) => AppDropdownItem(
                                          title: e.name(context),
                                          subtitle: e.description(context),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  label: "Subject",
                                  initialValue: state.subject,
                                  isRequired: true,
                                  labelHelpText: _getPlaceholdersForEventType(
                                    state.eventType,
                                  ),
                                  onChanged: context
                                      .read<EmailTemplateDetailsBloc>()
                                      .onSubjectChanged,
                                ),
                                // Provider Template ID field (only when ProviderTemplate mode)
                                if (state.contentSource ==
                                    Enum$EmailContentSource
                                        .ProviderTemplate) ...[
                                  const SizedBox(height: 16),
                                  AppTextField(
                                    label: "Provider Template ID",
                                    initialValue: state.providerTemplateId,
                                    isRequired: true,
                                    labelHelpText:
                                        "The template ID from SendGrid or MailerSend",
                                    onChanged: context
                                        .read<EmailTemplateDetailsBloc>()
                                        .onProviderTemplateIdChanged,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Available Placeholders",
                                    style: context.textTheme.bodyMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _getPlaceholdersForEventType(
                                      state.eventType,
                                    ),
                                    style: context.textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Use these variables in your SendGrid/MailerSend template. SendGrid uses {{variableName}} syntax, MailerSend uses {${'{'}\$variableName{'}'}} syntax.",
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color:
                                              context.colors.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                                // Inline body fields (only when Inline mode)
                                if (state.contentSource ==
                                    Enum$EmailContentSource.Inline) ...[
                                  const SizedBox(height: 16),
                                  AppTextField(
                                    label: "Body (HTML)",
                                    initialValue: state.bodyHtml,
                                    isRequired: true,
                                    maxLines: 10,
                                    labelHelpText: _getPlaceholdersForEventType(
                                      state.eventType,
                                    ),
                                    onChanged: context
                                        .read<EmailTemplateDetailsBloc>()
                                        .onBodyHtmlChanged,
                                  ),
                                  const SizedBox(height: 16),
                                  AppTextField(
                                    label: "Body (Plain Text)",
                                    initialValue: state.bodyPlainText,
                                    isRequired: false,
                                    maxLines: 5,
                                    labelHelpText:
                                        "Optional plain text version. ${_getPlaceholdersForEventType(state.eventType)}",
                                    onChanged: context
                                        .read<EmailTemplateDetailsBloc>()
                                        .onBodyPlainTextChanged,
                                  ),
                                ],
                                const SizedBox(height: 16),
                                Text(
                                  "Recipients",
                                  style: context.textTheme.bodyMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  label: "CC Recipients",
                                  initialValue: state.cc,
                                  isRequired: false,
                                  labelHelpText:
                                      "Comma-separated email addresses to CC on this notification (e.g., admin@example.com, hr@example.com)",
                                  onChanged: context
                                      .read<EmailTemplateDetailsBloc>()
                                      .onCcChanged,
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
            ),
          ],
        ),
      ),
    );
  }
}
