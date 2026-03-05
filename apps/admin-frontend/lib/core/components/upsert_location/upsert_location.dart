import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class UpsertLocationDialog extends StatefulWidget {
  final Fragment$Address? addressToEdit;

  const UpsertLocationDialog({super.key, this.addressToEdit});

  @override
  State<UpsertLocationDialog> createState() => _AddNewLocationDialogState();
}

class _AddNewLocationDialogState extends State<UpsertLocationDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      icon: BetterIcons.gps01Filled,
      title: context.tr.addNewLocation,
      subtitle: context.tr.addEditThisAddress,
      onClosePressed: () => Navigator.of(context).pop(),
      primaryButton: AppFilledButton(
        text: context.tr.saveChanges,
        onPressed: () {},
      ),
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: AppGenericMap(
              mode: MapViewMode.picker,
              interactive: true,
              centerMarkerBuilder: (context, key, address) =>
                  AppRodPin.centerMarkerDestination(key: key),
              initialLocation: widget.addressToEdit?.toGenericMapPlace(),
              hasSearchBar: true,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: context.tr.title,
                  hint: context.tr.homeWorkEtc,
                  isFilled: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdownField.single(
                  label: context.tr.type,
                  items: Enum$RiderAddressType.values
                      .where((e) => e != Enum$RiderAddressType.$unknown)
                      .map(
                        (e) => AppDropdownItem(
                          value: e,
                          title: e.toLocalizedString(context),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: context.tr.address,
            hint: context.tr.enterYourAddress,
            isFilled: true,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
