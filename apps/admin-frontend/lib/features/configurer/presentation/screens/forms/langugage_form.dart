import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_currency/dropdown_language.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/form_container.dart';

class LangugageForm extends StatelessWidget {
  const LangugageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              context.tr.language,
              style: context.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.selectLanguage,
            style: context.textTheme.bodyMedium?.variant(context),
          ),
          const SizedBox(height: 36),
          SizedBox(width: 600, child: AppDropdownLanguage()),
          const SizedBox(height: 36),
          Align(
            alignment: Alignment.centerRight,
            child: AppFilledButton(
              onPressed: () {
                context.read<ConfigurerBloc>().goToPage(
                  ConfigurerPage.personalNumber,
                );
              },
              text: context.tr.next,
              suffixIcon: BetterIcons.arrowRight02Outline,
            ),
          ),
        ],
      ),
    );
  }
}
