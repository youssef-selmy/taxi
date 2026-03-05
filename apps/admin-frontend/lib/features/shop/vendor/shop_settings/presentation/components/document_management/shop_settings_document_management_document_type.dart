import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ShopSettingsDocumentManagementDocumentType extends StatelessWidget {
  const ShopSettingsDocumentManagementDocumentType({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopSettingsBloc>();
    return BlocBuilder<ShopSettingsBloc, ShopSettingsState>(
      builder: (context, state) {
        return AppTextField(
          initialValue: state.shopDocuments[index].title,
          hint: context.tr.enterType,
          onChanged: (value) {
            bloc.onDocumentTitleChange(index, value);
          },
          keyboardType: TextInputType.number,
          validator: FormBuilderValidators.required(),
        );
      },
    );
  }
}
