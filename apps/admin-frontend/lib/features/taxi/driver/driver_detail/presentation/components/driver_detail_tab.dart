import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/blocs/driver_detail.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/components/driver_detail_informations.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/components/driver_detail_services.dart';

class DriverDetailTab extends StatelessWidget {
  DriverDetailTab({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverDetailBloc>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DriverDetailInformations(),
            const SizedBox(height: 32),
            DriverDetailServices(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppFilledButton(
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      _formKey.currentState!.save();
                      bloc.onUpdateDriver();
                    }
                  },
                  text: context.tr.saveChanges,
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
