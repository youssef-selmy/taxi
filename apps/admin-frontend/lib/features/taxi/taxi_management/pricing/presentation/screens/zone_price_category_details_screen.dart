import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/blocs/zone_price_category_details.cubit.dart';

@RoutePage()
class ZonePriceCategoryDetailsScreen extends StatelessWidget {
  final String? zonePriceCategoryId;

  ZonePriceCategoryDetailsScreen({super.key, this.zonePriceCategoryId});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ZonePriceCategoryDetailsBloc()..onStarted(id: zonePriceCategoryId),
      child: BlocBuilder<ZonePriceCategoryDetailsBloc, ZonePriceCategoryDetailsState>(
        builder: (context, state) {
          final bloc = context.read<ZonePriceCategoryDetailsBloc>();
          return Container(
            margin: context.pagePadding,
            color: context.colors.surface,
            child:
                BlocConsumer<
                  ZonePriceCategoryDetailsBloc,
                  ZonePriceCategoryDetailsState
                >(
                  listener: (context, state) {
                    if (state.networkStateSave.isLoaded) {
                      context.router.back();
                    }
                  },
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: switch (state.zonePriceCategory) {
                        ApiResponseInitial() => const SizedBox(),
                        ApiResponseLoading() => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        ApiResponseError(:final message) => Center(
                          child: Text(message.toString()),
                        ),
                        ApiResponseLoaded(:final data) => Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              PageHeader(
                                title: isEdit
                                    ? "${context.tr.editZonePriceOverrideCategory} $zonePriceCategoryId"
                                    : context
                                          .tr
                                          .createZonePriceOverrideCategory,
                                showBackButton: true,
                                subtitle: isEdit
                                    ? context
                                          .tr
                                          .editZonePriceOverrideCategorySubtitle
                                    : context
                                          .tr
                                          .createZonePriceOverrideCategorySubtitle,
                                actions: [
                                  AppFilledButton(
                                    text: context.tr.saveChanges,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        bloc.onSave();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          onChanged: bloc.onNameChanged,
                                          initialValue: data?.name,
                                          label: context.tr.name,
                                          hint: context.tr.nameHint,
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
          );
        },
      ),
    );
  }

  bool get isEdit => zonePriceCategoryId != null;
}
