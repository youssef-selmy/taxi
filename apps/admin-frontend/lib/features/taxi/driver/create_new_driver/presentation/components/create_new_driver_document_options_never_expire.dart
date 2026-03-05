import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';

class CreateNewDriverDocumentOptionsNeverExpire extends StatelessWidget {
  const CreateNewDriverDocumentOptionsNeverExpire({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewDriverBloc>();
    return BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            AppCheckbox(
              value: state.driverDocumentsState.isLoading
                  ? false
                  : state.driverDocuments?.driverDocumentsExpireDate?[index],
              onChanged: (value) {
                bloc.onDriverDocumentExpireDateChange(index, value);
              },
            ),
            const SizedBox(width: 8),
            Text(context.tr.neverExpires, style: context.textTheme.bodyMedium),
          ],
        );
      },
    );
  }
}
