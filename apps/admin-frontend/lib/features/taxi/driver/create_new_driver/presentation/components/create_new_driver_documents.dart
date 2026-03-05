import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.mock.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/components/create_new_driver_document_options_expire_date.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/components/create_new_driver_document_options_image.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/components/create_new_driver_document_options_retention_policy.dart';

// ignore: must_be_immutable
class CreateNewDriverDocuments extends StatelessWidget {
  CreateNewDriverDocuments({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LargeHeader(title: context.tr.documents),
              const Divider(height: 32),
              const SizedBox(height: 8),
              Skeletonizer(
                enableSwitchAnimation: true,
                enabled: state.driverDocumentsState.isLoading,
                child: Column(
                  children:
                      (state.driverDocumentsState.isLoading
                              ? List.generate(2, (_) => mockDriverDocument1)
                              : state
                                    .driverDocumentsState
                                    .data!
                                    .driverDocuments)
                          .mapIndexed(
                            (index, document) => context.responsive(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                            CreateNewDriverDocumentOptionsImage(
                                              documnet: document,
                                              index: index,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    context.tr.expiryDate,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  CreateNewDriverDocumentOptionsExpireDate(
                                    index: index,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Divider(height: 1),
                                  ),
                                  Text(
                                    context.tr.retentionPolicy,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  CreateNewDriverDocumentOptionsRetentionPolicy(
                                    document: document,
                                    index: index,
                                  ),
                                ],
                              ),
                              lg: Row(
                                children: <Widget>[
                                  CreateNewDriverDocumentOptionsImage(
                                    documnet: document,
                                    index: index,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    context.tr.expiryDate,
                                                    style: context
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  CreateNewDriverDocumentOptionsExpireDate(
                                                    index: index,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          child: Divider(height: 1),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                context.tr.retentionPolicy,
                                                style: context
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                            Expanded(
                                              child:
                                                  CreateNewDriverDocumentOptionsRetentionPolicy(
                                                    document: document,
                                                    index: index,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList()
                          .separated(separator: Divider(height: 24)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
