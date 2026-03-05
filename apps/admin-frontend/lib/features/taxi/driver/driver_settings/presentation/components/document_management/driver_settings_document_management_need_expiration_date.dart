import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';

class DriverSettingsDocumentManagementNeedExpirationDate
    extends StatelessWidget {
  const DriverSettingsDocumentManagementNeedExpirationDate({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverSettingsBloc>();
    return BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                context.tr.needExpirationDate,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: context.responsive(
                  MainAxisAlignment.end,
                  lg: MainAxisAlignment.start,
                ),
                children: [
                  Switch(
                    value: state.driverDocuments[index].hasExpiryDate,
                    onChanged: (value) {
                      bloc.onNeedExpirationDateChange(index, value);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
