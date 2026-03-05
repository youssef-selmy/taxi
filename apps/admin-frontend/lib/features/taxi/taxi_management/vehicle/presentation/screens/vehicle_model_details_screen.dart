import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/presentation/blocs/vehicle_model_details.cubit.dart';

@RoutePage()
class VehicleModelDetailsScreen extends StatelessWidget {
  final String? modelId;
  VehicleModelDetailsScreen({super.key, @QueryParam('modelId') this.modelId});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VehicleModelDetailsBloc()..onStarted(vehicleModelId: modelId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: BlocConsumer<VehicleModelDetailsBloc, VehicleModelDetailsState>(
          listener: (context, state) {
            if (state.networkStateSave.isLoaded) {
              context.router.back();
            }
          },
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: switch (state.vehicleModel) {
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
                        title: context.tr.vehicleModelDetails,
                        subtitle: context.tr.vehicleModelDetailsSubtitle,
                        showBackButton: true,
                        actions: [
                          AppFilledButton(
                            text: context.tr.saveChanges,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<VehicleModelDetailsBloc>()
                                    .onSave();
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
                                  label: context.tr.name,
                                  initialValue: state.name,
                                  onChanged: context
                                      .read<VehicleModelDetailsBloc>()
                                      .onNameChanged,
                                  validator: (value) => (value?.isEmpty ?? true)
                                      ? context.tr.titleRequired
                                      : null,
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
