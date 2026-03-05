import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/features/fullscreen_image_viewer/fullscreen_image_viewer_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/presentation/blocs/driver_detail_documents.bloc.dart';
import 'package:better_icons/better_icons.dart';

class DriverDetailDocumentsScreen extends StatelessWidget {
  const DriverDetailDocumentsScreen({super.key, required this.driverId});

  final String driverId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDetailDocumentsBloc()..onStarted(driverId),
      child: BlocBuilder<DriverDetailDocumentsBloc, DriverDetailDocumentsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                LargeHeader(title: context.tr.documents),
                const Divider(height: 16),
                const SizedBox(height: 32),
                AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: switch (state.driverDocumentsState) {
                    ApiResponseInitial() => const SizedBox(),
                    ApiResponseLoading() || ApiResponseLoaded() => Skeletonizer(
                      enableSwitchAnimation: true,
                      enabled: state.driverDocumentsState.isLoading,
                      child: Wrap(
                        spacing: 48,
                        runSpacing: 48,
                        children: List.generate(
                          state.driverDocumentsState.isLoading
                              ? 2
                              : state
                                        .driverDocumentsState
                                        .data
                                        ?.driverToDriverDocuments
                                        .edges
                                        .length ??
                                    0,
                          (index) {
                            final Fragment$driverToDriverDocument document =
                                state.driverDocumentsState.isLoading
                                ? mockDriverToDriverDocument1
                                : state
                                      .driverDocumentsState
                                      .data!
                                      .driverToDriverDocuments
                                      .edges[index]
                                      .node;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document.driverDocument.title,
                                  style: context.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!state
                                          .driverDocumentsState
                                          .isLoading) {
                                        FullscreenImageViewerDialog.show(
                                          context,
                                          imageUrl: document.media.address,
                                          title: document.driverDocument.title,
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: kBorder(context),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: document.media.widget(
                                            width: 280,
                                            height: 160,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      BetterIcons.alertCircleFilled,
                                      color: context.colors.warning,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      context.tr.driverDocumentWillBeDeletedIn,
                                      style: context.textTheme.labelMedium
                                          ?.variant(context),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      document.expiresAt?.toTimeAgo ??
                                          context.tr.never,
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                            color: context.colors.warning,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    ApiResponseError(:final message) => Text(message),
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
