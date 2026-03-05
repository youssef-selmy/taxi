import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/service_option.dart';
import 'package:admin_frontend/core/enums/service_option_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/blocs/pricing_details.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AddServiceOptionDialog extends StatefulWidget {
  const AddServiceOptionDialog({super.key});

  @override
  State<AddServiceOptionDialog> createState() => _AddServiceOptionDialogState();
}

class _AddServiceOptionDialogState extends State<AddServiceOptionDialog> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  Enum$ServiceOptionType? type;
  Enum$ServiceOptionIcon? icon;
  double? price;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PricingDetailsBloc(),
      child: BlocBuilder<PricingDetailsBloc, PricingDetailsState>(
        builder: (context, state) {
          return AppResponsiveDialog(
            maxWidth: 600,
            icon: BetterIcons.addCircleFilled,
            title: context.tr.addServiceOption,
            subtitle: context.tr.serviceOptionsSubtitle,
            primaryButton: AppFilledButton(
              text: context.tr.insert,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await context.read<PricingDetailsBloc>().onServiceOptionAdded(
                    Input$ServiceOptionInput(
                      name: name!,
                      type: type!,
                      icon: icon!,
                      additionalFee: price,
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop(true);
                }
              },
            ),
            secondaryButton: AppOutlinedButton(
              text: context.tr.cancel,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    label: context.tr.name,
                    validator: (p0) => p0 == null || p0.isEmpty
                        ? context.tr.fieldIsRequired
                        : null,
                    onSaved: (p0) => name = p0,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppDropdownField.single(
                    label: context.tr.type,
                    validator: (p0) =>
                        p0 == null ? context.tr.fieldIsRequired : null,
                    onSaved: (p0) => type = p0,
                    onChanged: (p0) {
                      setState(() {
                        type = p0;
                      });
                    },
                    items: Enum$ServiceOptionType.values
                        .where((e) => e != Enum$ServiceOptionType.$unknown)
                        .map(
                          (e) =>
                              AppDropdownItem(title: e.name(context), value: e),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  AppDropdownField.single(
                    label: context.tr.icon,
                    validator: (p0) =>
                        p0 == null ? context.tr.fieldIsRequired : null,
                    onSaved: (p0) => icon = p0,
                    onChanged: (p0) {
                      setState(() {
                        icon = p0;
                      });
                    },
                    items: Enum$ServiceOptionIcon.values
                        .where((e) => e != Enum$ServiceOptionIcon.$unknown)
                        .map(
                          (e) =>
                              AppDropdownItem(title: e.name(context), value: e),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  if (type == Enum$ServiceOptionType.Paid)
                    AppNumberField(
                      title: context.tr.price,
                      hint: context.tr.enterPrice,
                      minValue: 0,
                      validator: (p0) =>
                          p0 == null ? context.tr.fieldIsRequired : null,
                      onSaved: (p0) => price = p0,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
