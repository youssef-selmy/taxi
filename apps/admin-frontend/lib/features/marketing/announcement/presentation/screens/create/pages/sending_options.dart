import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/accordion/checkable_accordion.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/blocs/create_announcement.cubit.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/dialogs/schedule_announcement.dart';
import 'package:better_icons/better_icons.dart';

class CreateAnnouncementSendingOptionsPage extends StatefulWidget {
  const CreateAnnouncementSendingOptionsPage({super.key});

  @override
  State<CreateAnnouncementSendingOptionsPage> createState() =>
      _CreateAnnouncementSendingOptionsPageState();
}

class _CreateAnnouncementSendingOptionsPageState
    extends State<CreateAnnouncementSendingOptionsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateAnnouncementBloc>();
    return BlocBuilder<CreateAnnouncementBloc, CreateAnnouncementState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: context.pagePaddingHorizontal,
                    child: Column(
                      children: [
                        LargeHeader(
                          title: context.tr.sendingOptions,
                          size: HeaderSize.large,
                        ),
                        const Divider(height: 32),
                        CheckableAccordion(
                          onChanged: bloc.onSendAsSmsChanged,
                          defaultValue: bloc.state.sendSMS,
                          title: context.tr.sendAsSms,
                          iconData: BetterIcons.message02Filled,
                          child: AppTextField(
                            label: context.tr.smsMessage,
                            hint: context.tr.enterSmsMessage,
                            initialValue: bloc.state.smsMessage,
                            validator: (value) {
                              if (bloc.state.sendSMS &&
                                  (value?.isEmpty ?? true)) {
                                return context.tr.smsMessageRequired;
                              }
                              return null;
                            },
                            maxLines: 3,
                            onChanged: bloc.onSmsMessageChanged,
                          ),
                        ),
                        // const SizedBox(height: 32),
                        // CheckableAccordion(
                        //   onChanged: bloc.onSendAsEmailChanged,
                        //   defaultValue: bloc.state.sendEmail,
                        //   title: context.tr.sendAsEmail,
                        //   iconData: BetterIcons.mail02Filled,
                        //   child: Column(
                        //     children: [
                        //       AppTextField(
                        //         label: context.tr.emailSubject,
                        //         hint: context.tr.enterEmailSubject,
                        //         initialValue: bloc.state.emailSubject,
                        //         validator: (value) {
                        //           if (bloc.state.sendEmail &&
                        //               (value?.isEmpty ?? true)) {
                        //             return context.tr.emailSubjectRequired;
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: bloc.onEmailSubjectChanged,
                        //       ),
                        //       const SizedBox(height: 16),
                        //       AppTextField(
                        //         label: context.tr.emailMessage,
                        //         hint: context.tr.enterEmailMessage,
                        //         initialValue: bloc.state.emailMessage,
                        //         validator: (value) {
                        //           if (bloc.state.sendEmail &&
                        //               (value?.isEmpty ?? true)) {
                        //             return context.tr.emailMessageRequired;
                        //           }
                        //           return null;
                        //         },
                        //         maxLines: 3,
                        //         onChanged: bloc.onEmailMessageChanged,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 32),
                        CheckableAccordion(
                          onChanged: bloc.onSendAsPushChanged,
                          defaultValue: bloc.state.sendPush,
                          title: context.tr.sendAsPush,
                          iconData: BetterIcons.notification02Filled,
                          child: Column(
                            children: [
                              AppTextField(
                                label: context.tr.pushTitle,
                                hint: context.tr.enterPushTitle,
                                validator: (value) {
                                  if (bloc.state.sendPush &&
                                      (value?.isEmpty ?? true)) {
                                    return context.tr.pushTitleRequired;
                                  }
                                  return null;
                                },
                                initialValue: bloc.state.pushTitle,
                                onChanged: bloc.onPushTitleChanged,
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                label: context.tr.pushMessage,
                                hint: context.tr.enterPushMessage,
                                initialValue: bloc.state.pushMessage,
                                validator: (value) {
                                  if (bloc.state.sendPush &&
                                      (value?.isEmpty ?? true)) {
                                    return context.tr.pushMessageRequired;
                                  }
                                  return null;
                                },
                                maxLines: 3,
                                onChanged: bloc.onPushMessageChanged,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    AppOutlinedButton(
                      onPressed: () {
                        bloc.onBackButtonPressed();
                      },
                      prefixIcon: BetterIcons.arrowLeft02Outline,
                      text: context.tr.back,
                    ),
                    const Spacer(),
                    AppOutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          useSafeArea: false,
                          builder: (context) {
                            return const ScheduleAnnouncementDialog();
                          },
                        );
                      },
                      prefixIcon: BetterIcons.clock01Filled,
                      text: context.tr.schedule,
                    ),
                    const SizedBox(width: 16),
                    AppFilledButton(
                      suffixIcon: BetterIcons.arrowRight02Outline,
                      text: context.tr.submit,
                      isDisabled: state.networkStateSave.isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.onSubmit(sendAt: null);
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
