import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/map/geofence_form_field.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/blocs/zone_price_details.bloc.dart';

@RoutePage()
class ZonePriceDetailsScreen extends StatelessWidget {
  final String? zonePriceId;
  final _formKey = GlobalKey<FormState>();

  ZonePriceDetailsScreen({super.key, this.zonePriceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ZonePriceDetailsBloc()..onStarted(id: zonePriceId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            PageHeader(
              title: context.tr.zonePriceDetails,
              subtitle: context.tr.zonePriceDetailsSubtitle,
              actions: [
                AppFilledButton(
                  text: context.tr.saveChanges,
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    context.read<ZonePriceDetailsBloc>().save();
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocConsumer<ZonePriceDetailsBloc, ZonePriceDetailsState>(
                listener: (context, state) {
                  if (state.networkStateSave.isLoaded) {
                    context.router.back();
                  }
                },
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: switch (state.zonePrice) {
                      ApiResponseInitial() => const SizedBox.shrink(),
                      ApiResponseLoading() => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                      ApiResponseError(:final message) => Center(
                        child: Text(message),
                      ),
                      ApiResponseLoaded(:final data) => _buildForm(
                        state,
                        data,
                        context,
                      ),
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form _buildForm(
    ZonePriceDetailsState state,
    Fragment$zonePrice? data,
    BuildContext context,
  ) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            LargeHeader(title: context.tr.details),
            const SizedBox(height: 16),
            AlignedGridView.count(
              crossAxisCount: 2,
              itemCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return AppTextField(
                      initialValue: data?.name,
                      label: context.tr.name,
                      onChanged: context
                          .read<ZonePriceDetailsBloc>()
                          .onNameChanged,
                      validator: (value) => value?.isEmpty ?? true
                          ? context.tr.fieldIsRequired
                          : null,
                    );
                  case 1:
                    return AppDropdownField.multi(
                      label: context.tr.services,
                      items: state.services
                          .map(
                            (e) => AppDropdownItem(title: e.name, value: e.id),
                          )
                          .toList(),
                      initialValue: state.serviceIds,
                      onChanged: context
                          .read<ZonePriceDetailsBloc>()
                          .onServiceChanged,
                    );
                  case 2:
                    return AppDropdownField.multi(
                      label: context.tr.fleets,
                      items: state.fleets
                          .map(
                            (e) => AppDropdownItem(title: e.name, value: e.id),
                          )
                          .toList(),
                      initialValue: state.fleetIds,
                      onChanged: context
                          .read<ZonePriceDetailsBloc>()
                          .onFleetIdsChanged,
                    );
                  default:
                    return const Text("Not implemented");
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: AppGeofenceFormField(
                initialValue: data?.from.firstOrNull,
                onChanged: context.read<ZonePriceDetailsBloc>().onFromChanged,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: AppGeofenceFormField(
                initialValue: data?.to.firstOrNull,
                onChanged: context.read<ZonePriceDetailsBloc>().onToChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
