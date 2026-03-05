import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateNewDriverDocumentOptionsImage extends StatelessWidget {
  const CreateNewDriverDocumentOptionsImage({
    super.key,
    required this.documnet,
    required this.index,
  });

  final int index;

  final Fragment$driverDocument documnet;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(documnet.title, style: context.textTheme.titleMedium),
            const SizedBox(height: 8),
            UploadFieldSmall(
              initialValue: state.driverDocumentsState.isLoading
                  ? null
                  : state.driverDocuments?.driverDocumentsImage?[index],
              validator: FormBuilderValidators.required(),
              onChanged: (value) {
                context.read<CreateNewDriverBloc>().onDriverDocumentImageChange(
                  index,
                  value,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
