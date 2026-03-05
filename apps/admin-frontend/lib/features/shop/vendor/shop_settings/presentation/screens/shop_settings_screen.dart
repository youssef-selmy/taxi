import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/components/document_management/shop_settings_document_management.dart';

@RoutePage()
class ShopSettingsScreen extends StatelessWidget {
  ShopSettingsScreen({super.key});

  final GlobalKey<FormState> formKeyDocuments = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSettingsBloc()..onStarted(),
      child: BlocBuilder<ShopSettingsBloc, ShopSettingsState>(
        builder: (context, state) {
          return Container(
            color: context.colors.surface,
            child: SingleChildScrollView(
              padding: context.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                    title: context.tr.shopSettings,
                    subtitle: context.tr.shopSettingsSubtitle,
                    actions: [
                      AppFilledButton(
                        onPressed: () {
                          if (formKeyDocuments.currentState!.validate()) {
                            context.read<ShopSettingsBloc>().saveChanges();
                          }
                        },
                        text: context.tr.saveChanges,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ShopSettingsDocumentManagement(formKey: formKeyDocuments),
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
