import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/compact_input/compact_input.dart';
import 'package:better_design_system/molecules/file_upload/file_upload.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef BetterProfileInfoScreenTemplate = AppProfileInfoScreenTemplate;

class AppProfileInfoScreenTemplate extends StatelessWidget {
  final ApiResponse<ProfileEntity> profileResponse;
  final Function(String)? onFirstNameChanged;
  final Function(String)? onLastNameChanged;
  final Function(String)? onEmailChanged;
  final Function()? onDeleteAccountPressed;
  final Future<ApiResponse<String>> Function(String, Uint8List?)? onUpload;

  const AppProfileInfoScreenTemplate({
    super.key,
    required this.profileResponse,
    this.onFirstNameChanged,
    this.onLastNameChanged,
    this.onEmailChanged,
    this.onDeleteAccountPressed,
    this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
        ),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            const SizedBox(height: 24),
            if (onUpload != null)
              AppFileUpload<String>(
                initialValue: profileResponse.data?.avatarUrl,
                imageUrlGetter: (imageUrl) => imageUrl,
                onUpload: onUpload!,
              ),
            if (onUpload == null)
              AppAvatar(
                imageUrl: profileResponse.data?.avatarUrl,
                size: AvatarSize.size80px,
              ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.surfaceVariantLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.strings.firstName,
                    style: context.textTheme.labelMedium?.variantLow(context),
                  ),
                  const SizedBox(height: 4),
                  AppCompactInput(
                    initialValue: profileResponse.data?.firstName,
                    prefixIcon: BetterIcons.userCircle02Outline,
                    onTextSubmitted: onFirstNameChanged?.call,
                    autofillHints: [AutofillHints.givenName],
                  ),
                  const AppDivider(height: 20),
                  Text(
                    context.strings.lastName,
                    style: context.textTheme.labelMedium?.variantLow(context),
                  ),
                  const SizedBox(height: 4),
                  AppCompactInput(
                    initialValue: profileResponse.data?.lastName,
                    prefixIcon: BetterIcons.userCircle02Outline,
                    autofillHints: [AutofillHints.familyName],
                    onTextSubmitted: onLastNameChanged?.call,
                  ),
                  const AppDivider(height: 20),
                  Text(
                    context.strings.email,
                    style: context.textTheme.labelMedium?.variantLow(context),
                  ),
                  const SizedBox(height: 4),
                  AppCompactInput(
                    initialValue: profileResponse.data?.email,
                    prefixIcon: BetterIcons.mail02Outline,
                    onTextSubmitted: onEmailChanged?.call,
                    autofillHints: [AutofillHints.email],
                  ),
                  const AppDivider(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      color: SemanticColor.error,
                      onPressed: onDeleteAccountPressed,
                      text: context.strings.deleteAccount,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEntity {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String mobileNumber;
  final String? avatarUrl;

  ProfileEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.avatarUrl,
  });
}
