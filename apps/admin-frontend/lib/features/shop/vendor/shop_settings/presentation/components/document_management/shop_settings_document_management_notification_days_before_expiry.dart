import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ShopSettingsDocumentManagementNotificationDaysBeforeExpiry
    extends StatelessWidget {
  const ShopSettingsDocumentManagementNotificationDaysBeforeExpiry({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopSettingsBloc>();
    return BlocBuilder<ShopSettingsBloc, ShopSettingsState>(
      builder: (context, state) {
        return AppNumberField.integer(
          initialValue: state.shopDocuments[index].notificationDaysBeforeExpiry,
          hint: '0',
          onChanged: (value) {
            bloc.onNotificationDaysBeforeExpiryChange(index, value!);
          },
          validator: FormBuilderValidators.required(),
        );
      },
    );
  }
}
