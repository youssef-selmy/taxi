import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/presentation/blocs/cancel_reason_details.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class CancelReasonDetailScreen extends StatelessWidget {
  final String? cancelReasonId;

  CancelReasonDetailScreen({super.key, @QueryParam() this.cancelReasonId});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CancelReasonDetailsBloc()..onStarted(id: cancelReasonId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: BlocConsumer<CancelReasonDetailsBloc, CancelReasonDetailsState>(
          listener: (context, state) {
            if (state.networkStateSave.isLoaded) {
              context.router.back();
            }
          },
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: switch (state.cancelReason) {
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
                    children: [
                      PageHeader(
                        title: context.tr.cancelReasonDetails,
                        subtitle: context.tr.editCancelReasonDetails,
                        showBackButton: true,
                        actions: [
                          AppFilledButton(
                            text: context.tr.saveChanges,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<CancelReasonDetailsBloc>()
                                    .onSaved();
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                AppTextField(
                                  label: context.tr.title,
                                  initialValue: state.name,
                                  onChanged: context
                                      .read<CancelReasonDetailsBloc>()
                                      .titleChanged,
                                  validator: (value) => (value?.isEmpty ?? true)
                                      ? context.tr.titleRequired
                                      : null,
                                ),
                                const SizedBox(height: 24),
                                AppDropdownField.single(
                                  label: context.tr.userType,
                                  initialValue: state.userType,
                                  onChanged: (value) => context
                                      .read<CancelReasonDetailsBloc>()
                                      .userTypeChanged(value),
                                  validator: (value) => value == null
                                      ? context.tr.userTypeRequired
                                      : null,
                                  items: [
                                    AppDropdownItem(
                                      title: context.tr.customer,
                                      value: Enum$AnnouncementUserType.Rider,
                                    ),
                                    AppDropdownItem(
                                      title: context.tr.driver,
                                      value: Enum$AnnouncementUserType.Driver,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
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
}
