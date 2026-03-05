import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/settings/presentation/blocs/settings.bloc.dart';

class SettingsPageHeader extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  const SettingsPageHeader({
    super.key,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return LargeHeader(
      title: title,
      size: HeaderSize.normal,
      showBackButton: context.responsive(true, lg: false),
      onBackButtonPressed: context.responsive(
        () => context.read<SettingsBloc>().goToRoute(null),
        lg: null,
      ),
      actions: actions,
    );
  }
}
