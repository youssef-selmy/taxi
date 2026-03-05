import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';

class ShopSettingsDocumentManagementIsRequired extends StatelessWidget {
  const ShopSettingsDocumentManagementIsRequired({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopSettingsBloc>();
    return BlocBuilder<ShopSettingsBloc, ShopSettingsState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                context.tr.isRequired,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: context.responsive(
                  MainAxisAlignment.end,
                  lg: MainAxisAlignment.start,
                ),
                children: [
                  Switch(
                    value: state.shopDocuments[index].isRequired,
                    onChanged: (value) {
                      bloc.onIsRequiredChange(index, value);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
