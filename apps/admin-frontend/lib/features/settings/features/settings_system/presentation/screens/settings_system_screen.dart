import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/upload_field/upload_field_large.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/settings/features/settings_system/presentation/blocs/settings_system.bloc.dart';
import 'package:admin_frontend/features/settings/presentation/components/settings_page_header.dart';

@RoutePage()
class SettingsSystemScreen extends StatelessWidget {
  const SettingsSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsSystemBloc()..onStarted(),
      child: BlocBuilder<SettingsSystemBloc, SettingsSystemState>(
        builder: (context, state) {
          final bloc = context.read<SettingsSystemBloc>();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SettingsPageHeader(
                  title: context.tr.systemSettings,
                  actions: [
                    AppFilledButton(
                      text: context.tr.saveChanges,
                      onPressed: () {
                        bloc.onSubmit();
                      },
                    ),
                  ],
                ),
                switch (state.systemSettingsState) {
                  ApiResponseLoaded() => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Google Maps API Key",
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Backend API Key",
                        initialValue: state.backendMapsAPIKey,
                        onChanged: bloc.onMapsAPIKeyChanged,
                      ),
                      const Divider(height: 48),
                      Text("MySQL", style: context.textTheme.titleMedium),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Host",
                        initialValue: state.mysqlHost,
                        onChanged: bloc.onMySQLHostChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Port",
                        initialValue: state.mysqlPort?.toString(),
                        onChanged: bloc.onMySQLPortChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Database",
                        initialValue: state.mysqlDatabase,
                        onChanged: bloc.onMySQLDatabaseChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Username",
                        initialValue: state.mysqlUser,
                        onChanged: bloc.onMySQLUsernameChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Password",
                        initialValue: state.mysqlPassword,
                        onChanged: bloc.onMySQLPasswordChanged,
                      ),
                      const Divider(height: 48),
                      Text("Redis", style: context.textTheme.titleMedium),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Host",
                        initialValue: state.redisHost,
                        onChanged: bloc.onRedisHostChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Port",
                        initialValue: state.redisPort?.toString(),
                        onChanged: bloc.onRedisPortChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Password",
                        initialValue: state.redisPassword,
                        onChanged: bloc.onRedisPasswordChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: "Database",
                        initialValue: state.redisDb?.toString(),
                        onChanged: bloc.onRedisDbChanged,
                      ),
                      const Divider(height: 48),
                      Text("Firebase", style: context.textTheme.titleMedium),
                      const SizedBox(height: 16),
                      UploadFieldLarge(
                        type: UploadFieldType.firebasePrivateKey,
                        onUploadFirebasePrivateKey:
                            bloc.onFirebasePrivateKeyChanged,
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                  _ => const Center(child: CupertinoActivityIndicator()),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}
