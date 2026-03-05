import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopSettingsDocumentManagementAddRetentionPolicy extends StatelessWidget {
  const ShopSettingsDocumentManagementAddRetentionPolicy({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        context.read<ShopSettingsBloc>().addDocumentRetentionPolicy(index);
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
