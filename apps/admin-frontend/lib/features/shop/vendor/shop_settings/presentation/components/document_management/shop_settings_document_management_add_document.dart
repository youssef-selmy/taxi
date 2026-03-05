import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopSettingsDocumentManagementAddDocument extends StatelessWidget {
  const ShopSettingsDocumentManagementAddDocument({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopSettingsBloc>();
    return AppOutlinedButton(
      onPressed: () => bloc.addDocument(),
      text: context.tr.addDocument,
      color: SemanticColor.primary,
      prefixIcon: BetterIcons.addCircleOutline,
    );
  }
}
