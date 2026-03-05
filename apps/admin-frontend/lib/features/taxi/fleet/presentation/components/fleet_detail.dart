import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/map/geofence_form_field.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/widgets/warning_text_widget.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FleetDetailTab extends StatelessWidget {
  const FleetDetailTab({super.key, required this.data});
  final Query$fleetDetails data;
  @override
  Widget build(BuildContext context) {
    final e = data.fleet;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LayoutGrid(
            rowGap: 16,
            columnGap: 16,
            columnSizes: context.responsive([auto], lg: [1.fr, 1.fr]),
            rowSizes: const [
              auto,
              auto,
              auto,
              auto,
              auto,
              auto,
              auto,
              auto,
              auto,
            ],
            children: <Widget>[
              AppTextField(
                showEditButton: true,
                initialValue: e.name,
                label: context.tr.name,
                hint: context.tr.enterName,
                validator: FormBuilderValidators.required(),
                onChanged: (value) =>
                    context.read<FleetDetailBloc>().onNameChanged(value),
              ),
              AppTextField(
                showEditButton: true,
                initialValue: e.userName,
                label: context.tr.userName,
                hint: context.tr.enterUserName,
                validator: FormBuilderValidators.required(),
                onChanged: context.read<FleetDetailBloc>().onUsernameChanged,
              ),
              AppTextField(
                initialValue: e.phoneNumber,
                showEditButton: true,
                label: context.tr.phoneNumber,
                validator: FormBuilderValidators.phoneNumber(),
                hint: context.tr.enterPhoneNumber,
                onChanged: (value) {
                  context.read<FleetDetailBloc>().onPhoneChanged(value);
                },
              ),
              AppTextField(
                initialValue: e.mobileNumber,
                showEditButton: true,
                label: context.tr.mobileNumber,
                validator: FormBuilderValidators.phoneNumber(),
                hint: context.tr.enterMobileNumber,
                onChanged: (value) {
                  context.read<FleetDetailBloc>().onMobileNumberChanged(value);
                },
              ),
              AppTextField(
                initialValue: e.address,
                showEditButton: true,
                label: context.tr.address,
                validator: FormBuilderValidators.required(),
                hint: context.tr.enterAddress,
                onChanged: (value) {
                  context.read<FleetDetailBloc>().onAddressChanged(value);
                },
              ).withGridPlacement(columnSpan: context.responsive(1, lg: 2)),
              AppTextField(
                initialValue: e.commissionSharePercent.toString(),
                showEditButton: true,
                keyboardType: TextInputType.number,
                label: context.tr.commissionPercentage,
                hint: "0",
                validator: FormBuilderValidators.required(),
                onChanged: (value) => context
                    .read<FleetDetailBloc>()
                    .onCommissionPercentageChanged(value),
              ),
              AppTextField(
                initialValue: e.commissionShareFlat.toString(),
                showEditButton: true,
                keyboardType: TextInputType.number,
                label: context.tr.commissionFlat,
                hint: "0",
                validator: FormBuilderValidators.required(),
                onChanged: (value) => context
                    .read<FleetDetailBloc>()
                    .onCommissionFlatChanged(value),
              ),
              AppTextField(
                initialValue: '${e.feeMultiplier ?? '0'}',
                showEditButton: true,
                keyboardType: TextInputType.number,
                label: context.tr.feeMultiplier,
                hint: "0",
                validator: FormBuilderValidators.required(),
                onChanged: (value) => context
                    .read<FleetDetailBloc>()
                    .onFeeMultiplierChanged(value),
              ),
              AppTextField(
                initialValue: e.accountNumber,
                showEditButton: true,
                label: context.tr.bankAccountInfo,
                hint: context.tr.enterInformation,
                validator: FormBuilderValidators.required(),
                onChanged: (value) => context
                    .read<FleetDetailBloc>()
                    .onBankAccountInfoChanged(value),
              ),
            ],
          ),
          const SizedBox(height: 32),
          LargeHeader(title: context.tr.exclusivityArea),
          SizedBox(
            height: 400,
            child: AppGeofenceFormField(
              initialValue: const [],
              validator: (value) => (value?.isEmpty ?? true)
                  ? context.tr.geofenceErrorMessage
                  : null,
              onChanged: (p0) =>
                  context.read<FleetDetailBloc>().onExclusivityAreasChanged(p0),
              onSaved: (newValue) => [],
            ),
          ),
          const SizedBox(height: 24),
          const WarningTextWidget(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppFilledButton(
                onPressed: () {
                  context.read<FleetDetailBloc>().onUpdateFleet();
                },
                text: context.tr.saveChanges,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
