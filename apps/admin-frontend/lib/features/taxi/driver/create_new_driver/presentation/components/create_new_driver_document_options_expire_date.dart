import 'package:better_design_system/molecules/date_picker_field/date_picker_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';

class CreateNewDriverDocumentOptionsExpireDate extends StatelessWidget {
  const CreateNewDriverDocumentOptionsExpireDate({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewDriverBloc>();
    return BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
      builder: (context, state) {
        return AppDatePickerField(
          validator: (value) {
            if (value == null) {
              return context.tr.fieldIsRequired;
            }
            // Validate date is in the future (after today)
            final today = DateTime.now();
            final todayDateOnly = DateTime(today.year, today.month, today.day);
            if (value.isBefore(todayDateOnly) ||
                value.isAtSameMomentAs(todayDateOnly)) {
              return 'Date must be in the future';
            }
            return null;
          },
          initialValue: state.driverDocumentsState.isLoading
              ? null
              : state.driverDocuments?.driverDocumentsExpireDateTime?[index] ??
                    DateTime.now(),
          onChanged: (value) {
            bloc.onDriverDocumentsExpireDateTimeChange(index, value);
          },
        );
      },
    );
  }
}
