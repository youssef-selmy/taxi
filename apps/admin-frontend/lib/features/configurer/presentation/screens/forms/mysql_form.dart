import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/form_container.dart';

class MySqlForm extends StatefulWidget {
  const MySqlForm({super.key});

  @override
  State<MySqlForm> createState() => _MySqlFormState();
}

class _MySqlFormState extends State<MySqlForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormContainer(
        child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppBackButton(
                      onPressed: () {
                        context.read<ConfigurerBloc>().goToPage(
                          ConfigurerPage.googleMaps,
                        );
                      },
                    ),
                  ),
                  Text(
                    "MySQL Information",
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Please enter your MySQL information",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      children: [
                        AppTextField(
                          label: "Host",
                          initialValue: state.mySqlHost,
                          onChanged: (value) {
                            context.read<ConfigurerBloc>().onMySqlHostChanged(
                              value,
                            );
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Host is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: "Port",
                          initialValue: state.mySqlPort.toString(),
                          onChanged: (value) {
                            context.read<ConfigurerBloc>().onMySqlPortChanged(
                              int.parse(value),
                            );
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          isFilled: true,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Port is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: "Database",
                          initialValue: state.mySqlDatabase,
                          onChanged: (value) {
                            context
                                .read<ConfigurerBloc>()
                                .onMySqlDatabaseChanged(value);
                          },
                          isFilled: true,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Database is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: "Username",
                          initialValue: state.mySqlUser,
                          onChanged: (value) {
                            context
                                .read<ConfigurerBloc>()
                                .onMySqlUsernameChanged(value);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: "Password",
                          obscureText: true,
                          initialValue: state.mySqlPassword,
                          onChanged: (value) {
                            context
                                .read<ConfigurerBloc>()
                                .onMySqlPasswordChanged(value);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppFilledButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ConfigurerBloc>().goToPage(
                            ConfigurerPage.redis,
                          );
                        }
                      },
                      text: context.tr.next,
                      suffixIcon: Icons.arrow_forward,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
