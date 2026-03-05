import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/sos/features/reasons/add_sos_reason/presentation/blocs/add_sos_reasson.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class AddSosReasonScreen extends StatelessWidget {
  AddSosReasonScreen({super.key, @QueryParam('sosReasonId') this.sosReassonId});

  final String? sosReassonId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSosReassonBloc()..onStarted(sosReassonId),
      child: BlocConsumer<AddSosReassonBloc, AddSosReassonState>(
        listener: (context, state) {
          if (state.networkStateSave is ApiResponseLoaded) {
            context.router.back();
          }
        },
        builder: (context, state) {
          return Container(
            margin: context.pagePadding,
            color: context.colors.surface,
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: switch (state.sosReasonDetailNetwork) {
                ApiResponseInitial() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ApiResponseError() => Center(child: Text(context.tr.error)),
                ApiResponseLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ApiResponseLoaded() => Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PageHeader(
                        showBackButton: true,
                        title: context.tr.addNewSosReasons,
                        subtitle: context.tr.riderSosReasonSubtitle,
                        actions: [
                          if (state.sosReassonId != null)
                            AppOutlinedButton(
                              onPressed: () {
                                context
                                    .read<AddSosReassonBloc>()
                                    .onDeleteSosReasson();
                              },
                              prefixIcon: BetterIcons.delete03Outline,
                              text: context.tr.delete,
                              color: SemanticColor.error,
                            ),
                          if (sosReassonId != null && state.isActive == true)
                            AppOutlinedButton(
                              onPressed: context
                                  .read<AddSosReassonBloc>()
                                  .onHideSosReasson,
                              prefixIcon: BetterIcons.viewOffSlashFilled,
                              text: context.tr.hide,
                              color: SemanticColor.neutral,
                            ),
                          if (state.sosReassonId != null &&
                              state.isActive == false)
                            AppOutlinedButton(
                              onPressed: context
                                  .read<AddSosReassonBloc>()
                                  .onShowSosReasson,
                              prefixIcon: BetterIcons.eyeFilled,
                              text: context.tr.show,
                              color: SemanticColor.neutral,
                            ),
                          AppFilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AddSosReassonBloc>().onSubmit();
                              }
                            },
                            text: state.sosReassonId == null
                                ? context.tr.create
                                : context.tr.saveChanges,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              initialValue: state.title,
                              label: context.tr.name,
                              validator: context.validateName,
                              hint: context.tr.enterName,
                              onChanged: context
                                  .read<AddSosReassonBloc>()
                                  .onReassonTitleChanged,
                            ),
                          ),
                          context.responsive(
                            const SizedBox(),
                            lg: const Expanded(child: SizedBox()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
