import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/features/fullscreen_image_viewer/fullscreen_image_viewer_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';

class DriverPendingVerificationReviewDocumentsOptionImage
    extends StatelessWidget {
  const DriverPendingVerificationReviewDocumentsOptionImage({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DriverPendingVerificationReviewBloc,
      DriverPendingVerificationReviewState
    >(
      builder: (context, state) {
        // Get document definition first
        final documentDefinitions =
            state.driverDocumentsState.data?.driverDocuments ?? [];

        // If loading or index out of bounds, show mock
        if (state.driverDocumentsState.isLoading ||
            documentDefinitions.isEmpty ||
            index >= documentDefinitions.length) {
          final document = mockDriverToDriverDocument1;

          return Container(
            decoration: BoxDecoration(
              border: kBorder(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: document.media.widget(width: 250, height: 160),
              ),
            ),
          );
        }

        // Find if driver has uploaded this document type
        final documentDefinition = documentDefinitions[index];
        final uploadedDocuments =
            state.driverDocumentsState.data?.driverToDriverDocuments.edges
                .map((e) => e.node)
                .toList() ??
            <Fragment$driverToDriverDocument>[];
        final uploadedDocument = uploadedDocuments.firstWhereOrNull(
          (doc) => doc.driverDocument.id == documentDefinition.id,
        );

        // Use uploaded document if exists, otherwise use mock
        final document = uploadedDocument ?? mockDriverToDriverDocument1;
        final hasUploadedDocument = uploadedDocument != null;

        return MouseRegion(
          cursor: hasUploadedDocument
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: hasUploadedDocument
                ? () {
                    FullscreenImageViewerDialog.show(
                      context,
                      imageUrl: document.media.address,
                      title: document.driverDocument.title,
                    );
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                border: kBorder(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: document.media.widget(width: 250, height: 160),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
