import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_large.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/form_container.dart';
import 'package:better_icons/better_icons.dart';

class FirebaseForm extends StatefulWidget {
  const FirebaseForm({super.key});

  @override
  State<FirebaseForm> createState() => _FirebaseFormState();
}

class _FirebaseFormState extends State<FirebaseForm> {
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
                          ConfigurerPage.redis,
                        );
                      },
                    ),
                  ),
                  Text(
                    "Firebase Information",
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Please enter your Firebase information",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: 700,
                    child: Column(
                      children: [
                        UploadFieldLarge(
                          type: UploadFieldType.firebasePrivateKey,
                          onUploadFirebasePrivateKey: (url) => context
                              .read<ConfigurerBloc>()
                              .onFirebaseApiKeyChanged(url),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppFilledButton(
                      onPressed: () {
                        context.read<ConfigurerBloc>().goToPage(
                          ConfigurerPage.confirmation,
                        );
                      },
                      text: context.tr.next,
                      prefixIcon: BetterIcons.arrowRight02Outline,
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
