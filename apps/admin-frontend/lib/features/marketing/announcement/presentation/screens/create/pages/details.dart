import 'package:better_design_system/molecules/date_range_picker_field/date_range_picker_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/blocs/create_announcement.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateAnnouncementDetailsPage extends StatefulWidget {
  const CreateAnnouncementDetailsPage({super.key});

  @override
  State<CreateAnnouncementDetailsPage> createState() =>
      _CreateAnnouncementDetailsPageState();
}

class _CreateAnnouncementDetailsPageState
    extends State<CreateAnnouncementDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateAnnouncementBloc>();
    return BlocBuilder<CreateAnnouncementBloc, CreateAnnouncementState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: context.pagePaddingHorizontal,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LargeHeader(
                        title: context.tr.details,
                        size: HeaderSize.large,
                      ),
                      const Divider(height: 32),
                      Form(
                        key: _formKey,
                        child: AlignedGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: context.responsive(1, lg: 2),
                          itemCount: 7,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          itemBuilder: (context, index) {
                            return switch (index) {
                              0 => AppTextField(
                                label: context.tr.title,
                                initialValue: state.title,
                                isRequired: true,
                                helpText:
                                    "It is recommended to keep the title below 20 characters.",
                                hint: context.tr.enterAnnouncementTitle,
                                validator: FormBuilderValidators.required(),
                                onChanged: bloc.onTitleChanged,
                              ),
                              1 => AppTextField(
                                label: context.tr.description,
                                initialValue: state.description,
                                hint: context.tr.enterAnnouncementDescription,
                                validator: FormBuilderValidators.required(),
                                onChanged: bloc.onDescriptionChanged,
                              ),
                              2 => AppDateRangePickerField(
                                isFilled: true,
                                label: 'Active Date',
                                isRequired: true,
                                activeDate:
                                    state.startDate == null ||
                                        state.endDate == null
                                    ? null
                                    : (state.startDate!, state.endDate!),
                                validator: (value) {
                                  if (value == null) {
                                    return context.tr.fieldIsRequired;
                                  }
                                  return null;
                                },
                                onChanged: bloc.onDateRangeChanged,
                              ),
                              3 => AppTextField(
                                label: "URL",
                                initialValue: state.url,
                                hint: context.tr.enterAnnouncement("URL"),
                                onChanged: bloc.onUrlChanged,
                              ),
                              4 => Row(
                                spacing: 16,
                                children: [
                                  Expanded(
                                    child: AppDropdownField.single(
                                      label: context.tr.appType,
                                      initialValue: state.appType,
                                      validator:
                                          FormBuilderValidators.required(),
                                      onChanged: bloc.onAppTypeChanged,
                                      items:
                                          [
                                                Enum$AppType.Taxi,
                                                Enum$AppType.Shop,
                                                Enum$AppType.Parking,
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
                                  if (state.appType == Enum$AppType.Taxi)
                                    Expanded(
                                      child: AppDropdownField.single(
                                        label: context.tr.userType,
                                        initialValue: state.userType,
                                        validator:
                                            state.appType == Enum$AppType.Taxi
                                            ? FormBuilderValidators.required()
                                            : null,
                                        onChanged: bloc.onUserTypeChanged,
                                        items:
                                            [
                                                  Enum$AnnouncementUserType
                                                      .Driver,
                                                  Enum$AnnouncementUserType
                                                      .Rider,
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
                              5 => SizedBox(),
                              6 => SizedBox(),
                              // 6 => AppFileUploadManager(
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
                              _ => const Text("Not implemented"),
                            };
                          },
                        ),
                      ),
                      const SizedBox(height: 400),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Spacer(),
                    AppFilledButton(
                      suffixIcon: BetterIcons.arrowRight02Outline,
                      text: context.tr.actionContinue,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.detailsPageCompleted();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
