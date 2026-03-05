import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:better_icons/better_icons.dart';

class DriverSettingsDocumentManagementAddRetentionPolicy
    extends StatelessWidget {
  const DriverSettingsDocumentManagementAddRetentionPolicy({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        context.read<DriverSettingsBloc>().addDocumentRetentionPolicy(index);
      },
      minimumSize: Size(0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            BetterIcons.addCircleOutline,
            size: 20,
            color: context.colors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            context.tr.addAnotherOption,
            style: context.textTheme.bodyMedium?.apply(
              color: context.colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
