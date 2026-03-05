import 'package:admin_frontend/config/env.dart';
import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/datasources/upload_datasource.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/features/settings_general/presentation/blocs/settings_general.bloc.dart';
import 'package:admin_frontend/features/settings/presentation/components/settings_page_header.dart';

@RoutePage()
class SettingsGeneralScreen extends StatelessWidget {
  const SettingsGeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsGeneralBloc()..onStarted(),
      child: BlocBuilder<SettingsGeneralBloc, SettingsGeneralState>(
        builder: (context, state) {
          return switch (state.profileState) {
            ApiResponseLoading() => const Center(
              child: CupertinoActivityIndicator(),
            ),
            ApiResponseLoaded() => SingleChildScrollView(
              child: Column(
                children: [
                  SettingsPageHeader(
                    title: context.tr.generalDetails,
                    actions: [
                      AppFilledButton(
                        text: context.tr.saveChanges,
                        onPressed: () =>
                            context.read<SettingsGeneralBloc>().onSubmit(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  context.responsive(
                    _buildMobileProfilePictureField(context, state),
                    lg: const SizedBox(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: LayoutGrid(
                          columnSizes: context.responsive(
                            [1.fr],
                            lg: [1.fr, 1.fr],
                          ),
                          rowSizes: List.generate(
                            context.responsive(5, lg: 4),
                            (_) => auto,
                          ),
                          rowGap: 16,
                          columnGap: 24,
                          children: [
                            AppTextField(
                              label: context.tr.firstName,
                              initialValue: state.firstName,
                              onChanged: context
                                  .read<SettingsGeneralBloc>()
                                  .onFirstNameChanged,
                            ),
                            AppTextField(
                              label: context.tr.lastName,
                              initialValue: state.lastName,
                              onChanged: context
                                  .read<SettingsGeneralBloc>()
                                  .onLastNameChanged,
                            ),
                            AppTextField(
                              label: context.tr.email,
                              initialValue: state.email,
                              onChanged: context
                                  .read<SettingsGeneralBloc>()
                                  .onEmailChanged,
                            ).withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                            AppPhoneNumberField(
                              label: context.tr.mobileNumber,
                              initialValue: (
                                Env.defaultCountry.iso2CountryCode,
                                state.mobileNumber,
                              ),
                              onChanged: context
                                  .read<SettingsGeneralBloc>()
                                  .onMobileNumberChanged,
                            ).withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                            AppTextField(
                              label: context.tr.userName,
                              initialValue: state.userName,
                              onChanged: context
                                  .read<SettingsGeneralBloc>()
                                  .onUserNameChanged,
                            ).withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                          ],
                        ),
                      ),
                      if (context.isDesktop) ...[
                        const SizedBox(width: 16),
                        _buildDesktopProfilePictureField(context, state),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }

  Widget _buildDesktopProfilePictureField(
    BuildContext context,
    SettingsGeneralState state,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: kBorder(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr.profilePicture, style: context.textTheme.bodyMedium),
          const SizedBox(height: 24),
          Row(
            children: [
              AppAvatar(
                imageUrl: state.profilePicture?.address,
                size: AvatarSize.size80px,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr.uploadProfilePicture,
                    style: context.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 8),
                  _buildUploadButtons(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildMobileProfilePictureField(
    BuildContext context,
    SettingsGeneralState state,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: kBorder(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              context.tr.profilePicture,
              style: context.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: AppAvatar(
              imageUrl: state.profilePicture?.address,
              size: AvatarSize.size80px,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              context.tr.uploadProfilePicture,
              style: context.textTheme.labelMedium,
            ),
          ),
          const SizedBox(height: 8),
          Center(child: _buildUploadButtons(context)),
        ],
      ),
    );
  }

  Widget _buildUploadButtons(BuildContext context) {
    final bloc = context.read<SettingsGeneralBloc>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextButton(
          text: context.tr.delete,
          color: SemanticColor.error,
          onPressed: () {
            bloc.onProfilePictureChanged(null);
          },
        ),
        const SizedBox(width: 16),
        AppTextButton(
          text: context.tr.change,
          color: SemanticColor.primary,
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.image,
              allowMultiple: false,
              withData: true,
            );
            if (result != null) {
              final media = await locator<UploadDatasource>().uploadImage(
                result.files.single.path!,
                fileBytes: result.files.single.bytes,
              );
              bloc.onProfilePictureChanged(media.data!);
            }
          },
        ),
      ],
    );
  }
}
