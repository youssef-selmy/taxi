import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:better_icons/better_icons.dart';

class RedisForm extends StatelessWidget {
  RedisForm({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ConfigurerBloc>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 24,
          right: 24,
          bottom: 24,
        ),
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
                        bloc.goToPage(ConfigurerPage.mySql);
                      },
                    ),
                  ),
                  Text(
                    "Redis Information",
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Please enter your Redis database information",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: 500,
                    child: Column(
                      children: [
                        AppTextField(
                          label: "Host",
                          initialValue: state.redisHost,
                          onChanged: bloc.onRedisHostChanged,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Host is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppNumberField.integer(
                          title: "Port",
                          isFilled: true,
                          initialValue: state.redisPort,
                          onChanged: bloc.onRedisPortChanged,
                          validator: (value) {
                            if (value == null) {
                              return "Port is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: context.tr.password,
                          obscureText: true,
                          initialValue: state.redisPassword,
                          onChanged: bloc.onRedisPasswordChanged,
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
                          bloc.goToPage(ConfigurerPage.firebase);
                        }
                      },
                      text: context.tr.next,
                      suffixIcon: BetterIcons.arrowRight02Outline,
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
