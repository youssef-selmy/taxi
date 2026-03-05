import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/molecules/date_range_picker_field/date_range_picker_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/screens/details/blocs/announcement_detail.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class AnnouncementDetailScreen extends StatelessWidget {
  final String? announcementId;

  const AnnouncementDetailScreen({
    super.key,
    @QueryParam('id') required this.announcementId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnnouncementDetailBloc()..onStarted(announcementId: announcementId!),
      child: BlocConsumer<AnnouncementDetailBloc, AnnouncementDetailState>(
        listener: (context, state) {
          if (state.deleteState.isLoaded || state.updateState.isLoaded) {
            context.router.replace(AnnouncementListRoute());
          }
        },
        builder: (context, state) {
          final bloc = context.read<AnnouncementDetailBloc>();
          return switch (state.announcementState) {
            ApiResponseInitial() => const SizedBox.shrink(),
            ApiResponseError(:final message) => Text(message),
            ApiResponseLoading() => const CupertinoActivityIndicator(),
            ApiResponseLoaded(:final data) => Container(
              color: context.colors.surface,
              margin: context.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageHeader(
                    title: context.tr.announcementDetails,
                    subtitle: context.tr.editAnnouncementDetails,
                    onBackButtonPressed: () =>
                        context.router.replace(AnnouncementListRoute()),
                    showBackButton: true,
                    actions: [
                      AppOutlinedButton(
                        color: SemanticColor.error,
                        onPressed: context
                            .read<AnnouncementDetailBloc>()
                            .onDelete,
                        text: context.tr.delete,
                      ),
                      AppFilledButton(
                        text: context.tr.saveChanges,
                        onPressed: context
                            .read<AnnouncementDetailBloc>()
                            .onSubmit,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  LargeHeader(title: context.tr.announcementDetails),
                  const SizedBox(height: 24),
                  LayoutGrid(
                    columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                    rowSizes: const [auto, auto, auto, auto],
                    rowGap: 16,
                    columnGap: 16,
                    children: [
                      AppTextField(
                        initialValue: data.title,
                        helpText:
                            "It is recommended to keep the title below 20 characters.",
                        onChanged: context
                            .read<AnnouncementDetailBloc>()
                            .onTitleChanged,
                        label: context.tr.title,
                      ),
                      AppTextField(
                        initialValue: data.description,
                        onChanged: context
                            .read<AnnouncementDetailBloc>()
                            .onDescriptionChanged,
                        label: context.tr.description,
                      ),
                      AppDateRangePickerField(
                        isFilled: true,
                        label: 'Active Date',
                        isRequired: true,
                        activeDate:
                            state.startDate == null || state.endDate == null
                            ? null
                            : (state.startDate!, state.endDate!),
                        validator: FormBuilderValidators.required(),
                        onChanged: bloc.onDateRangeChanged,
                      ),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: AppDropdownField.single(
                              label: context.tr.appType,
                              initialValue: data.appType,
                              onChanged: context
                                  .read<AnnouncementDetailBloc>()
                                  .onAppTypeChanged,
                              items: Enum$AppType.values
                                  .where(
                                    (appType) =>
                                        appType != Enum$AppType.$unknown,
                                  )
                                  .map(
                                    (appType) => AppDropdownItem(
                                      value: appType,
                                      title: appType.name,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          if (state.appType == Enum$AppType.Taxi)
                            Expanded(
                              child: AppDropdownField.single(
                                label: context.tr.userType,
                                initialValue: state.userType,
                                onChanged: context
                                    .read<AnnouncementDetailBloc>()
                                    .onUserTypeChanged,
                                items:
                                    [
                                          Enum$AnnouncementUserType.Driver,
                                          Enum$AnnouncementUserType.Rider,
                                        ]
                                        .map(
                                          (e) => AppDropdownItem(
                                            title: e.name,
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                        ],
                      ),
                      AppTextField(
                        initialValue: data.url,
                        onChanged: context
                            .read<AnnouncementDetailBloc>()
                            .onUrlChanged,
                        label: "URL",
                      ),
                      SizedBox(),
                      // AppFileUploadManager(
                      //   primaryMessage: 'Upload Image',
                      //   secondaryMessage:
                      //       'JPG, PNG, HEIC, HEIF files. Max size 5MB',
                      //   buttonText: 'Upload',
                      //   cancelButtonText: 'Cancel',
                      //   onUpload: (files) {
                      //     return locator<UploadDatasource>()
                      //         .uploadImageWithProgress(
                      //           filePath: files.first.path!,
                      //           onComplete: (media) {
                      //             bloc.onImageUploaded(media);
                      //           },
                      //         );
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          };
        },
      ),
    );
  }
}
