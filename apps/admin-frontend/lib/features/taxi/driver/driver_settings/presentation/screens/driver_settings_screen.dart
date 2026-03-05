import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/document_management/driver_settings_document_management.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/work_hours/driver_settings_work_hours.dart';

@RoutePage()
class DriverSettingsScreen extends StatelessWidget {
  DriverSettingsScreen({super.key});

  final GlobalKey<FormState> formKeyDocuments = GlobalKey<FormState>();

  final GlobalKey<FormState> formKeyWorkHours = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverSettingsBloc()..onStarted(),
      child: BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: context.pagePadding,
            child: Container(
              color: context.colors.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                    title: context.tr.driversSettings,
                    subtitle: context.tr.settingsRelatedToDriverUsers,
                    actions: [
                      AppFilledButton(
                        onPressed: () {
                          if (formKeyDocuments.currentState!.validate() &&
                              formKeyWorkHours.currentState!.validate()) {
                            context.read<DriverSettingsBloc>().saveChanges();
                          }
                        },
                        text: context.tr.saveChanges,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DriverSettingsWorkHours(formKey: formKeyWorkHours),
                  const SizedBox(height: 32),
                  DriverSettingsDocumentManagement(formKey: formKeyDocuments),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
