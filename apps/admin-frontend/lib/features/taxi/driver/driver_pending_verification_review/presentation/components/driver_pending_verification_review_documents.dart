import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_documents_option_expire_date.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_documents_option_image.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_documents_option_retention_policy.dart';

class DriverPendingVerificationReviewDocuments extends StatelessWidget {
  const DriverPendingVerificationReviewDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch is now called from parent screen when step changes
    return BlocBuilder<
      DriverPendingVerificationReviewBloc,
      DriverPendingVerificationReviewState
    >(
      builder: (context, state) {
        return switch (state.driverDocumentsState) {
          ApiResponseLoaded() || ApiResponseLoading() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AppAvatar(
                    imageUrl: state.driverReview?.media?.address,
                    size: AvatarSize.size40px,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.tr.driver,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      Text(
                        state.driverReview?.firstName ?? '',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              LargeHeader(title: context.tr.documents),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 32),
              Skeletonizer(
                enableSwitchAnimation: true,
                enabled: state.driverDocumentsState.isLoading,
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.driverDocumentsState.isLoading
                          ? 2
                          : state
                                    .driverDocumentsState
                                    .data
                                    ?.driverDocuments
                                    .length ??
                                0,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 24);
                      },
                      itemBuilder: (context, index) {
                        // Get document definition
                        final documentDefinition =
                            state.driverDocumentsState.isLoading
                            ? mockDriverToDriverDocument1.driverDocument
                            : state
                                  .driverDocumentsState
                                  .data!
                                  .driverDocuments[index];

                        // Find if driver has uploaded this document type
                        final uploadedDocument =
                            state.driverDocumentsState.isLoading
                            ? mockDriverToDriverDocument1
                            : state
                                  .driverDocumentsState
                                  .data!
                                  .driverToDriverDocuments
                                  .edges
                                  .map((e) => e.node)
                                  .firstWhereOrNull(
                                    (doc) =>
                                        doc.driverDocument.id ==
                                        documentDefinition.id,
                                  );

                        // Create a pseudo document for display
                        final document =
                            uploadedDocument ??
                            Fragment$driverToDriverDocument(
                              id: '',
                              driverDocument: documentDefinition,
                              media: mockDriverToDriverDocument1.media,
                              retentionPolicy: null,
                              expiresAt: null,
                            );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document.driverDocument.title,
                              style: context.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            context.responsive(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child:
                                            DriverPendingVerificationReviewDocumentsOptionImage(
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
                                  DriverPendingVerificationReviewDocumentsOptionExpireDate(
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
                                  DriverPendingVerificationReviewDocumentsOptionRetentionPolicy(
                                    document: document,
                                    index: index,
                                  ),
                                ],
                              ),
                              lg: Row(
                                children: <Widget>[
                                  DriverPendingVerificationReviewDocumentsOptionImage(
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
                                                  DriverPendingVerificationReviewDocumentsOptionExpireDate(
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
                                                  DriverPendingVerificationReviewDocumentsOptionRetentionPolicy(
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
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ],
          ),
          ApiResponseError(:final errorMessage) => Center(
            child: Text(
              errorMessage ?? context.tr.somethingWentWrong,
              style: context.textTheme.bodyMedium,
            ),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
