import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_password/presentation/blocs/driver_detail_password.bloc.dart';

class DriverDetailPasswordScreen extends StatefulWidget {
  const DriverDetailPasswordScreen({super.key, required this.driverId});

  final String driverId;

  @override
  State<DriverDetailPasswordScreen> createState() =>
      _DriverDetailPasswordScreenState();
}

class _DriverDetailPasswordScreenState
    extends State<DriverDetailPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriverDetailPasswordBloc()..onStarted(widget.driverId),
      child: BlocBuilder<DriverDetailPasswordBloc, DriverDetailPasswordState>(
        builder: (context, state) {
          return switch (state.updatePasswordState) {
            ApiResponseLoading() => Center(child: CupertinoActivityIndicator()),
            _ => LayoutGrid(
              columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
              rowSizes: [auto, auto],
              rowGap: 16,
              columnGap: 16,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        validator: (p0) => (p0?.isEmpty ?? true)
                            ? context.tr.passwordRequired
                            : null,
                        label: context.tr.password,
                        hint: context.tr.enterPassword,
                        onChanged: context
                            .read<DriverDetailPasswordBloc>()
                            .onPasswordChanged,
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        validator: (p0) {
                          if ((p0?.isEmpty ?? true)) {
                            return context.tr.confirmPasswordRequired;
                          }
                          if (p0 != state.password) {
                            return context.tr.passwordsDoNotMatch;
                          }
                          return null;
                        },
                        label: context.tr.confirmPassword,
                        hint: context.tr.enterPassword,
                        onChanged: context
                            .read<DriverDetailPasswordBloc>()
                            .onConfirmPasswordChanged,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppFilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<DriverDetailPasswordBloc>()
                                  .onUpdatePassword();
                            }
                          },
                          text: context.tr.submit,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          };
        },
      ),
    );
  }
}
