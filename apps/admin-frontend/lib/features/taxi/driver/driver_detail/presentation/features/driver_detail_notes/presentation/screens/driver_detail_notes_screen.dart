import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_note.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/presentation/blocs/driver_detail_notes.bloc.dart';

class DriverDetailNotesScreen extends StatelessWidget {
  DriverDetailNotesScreen({super.key, required this.driverId});

  final String driverId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDetailNotesBloc()..onStarted(driverId),
      child: BlocBuilder<DriverDetailNotesBloc, DriverDetailNotesState>(
        builder: (context, driverNotesstate) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  top: false,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      border: kBorder(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          child: LargeHeader(title: context.tr.notes),
                        ),
                        const Divider(height: 1),
                        AnimatedSwitcher(
                          duration: kThemeAnimationDuration,
                          child: switch (driverNotesstate
                              .driverDetailNotesState) {
                            ApiResponseInitial() => const SizedBox(),
                            ApiResponseLoading() ||
                            ApiResponseLoaded() => Skeletonizer(
                              enabled: driverNotesstate
                                  .driverDetailNotesState
                                  .isLoading,
                              enableSwitchAnimation: true,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24,
                                ),
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount:
                                          driverNotesstate
                                              .driverDetailNotesState
                                              .isLoading
                                          ? 3
                                          : driverNotesstate
                                                    .driverDetailNotesState
                                                    .data
                                                    ?.driverNotes
                                                    .nodes
                                                    .length ??
                                                0,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 16),
                                      itemBuilder: (context, index) {
                                        var note =
                                            driverNotesstate
                                                .driverDetailNotesState
                                                .isLoading
                                            ? mockDriverNote1
                                            : driverNotesstate
                                                  .driverDetailNotesState
                                                  .data
                                                  ?.driverNotes
                                                  .nodes[index];
                                        return ChatBubble(
                                          message: note!.note,
                                          isMe:
                                              state.profile?.id ==
                                              note.staff.id,
                                          time: note.createdAt,
                                          avatar: note.staff.media?.address,
                                          name: note.staff.userName,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            ApiResponseError(:final message) => Text(message),
                          },
                        ),
                        const Divider(height: 1),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: AppSendMessage(
                              sendState: driverNotesstate.createDriverNoteState,
                              onChanged: context
                                  .read<DriverDetailNotesBloc>()
                                  .onNoteChange,
                              onSend: (note) {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<DriverDetailNotesBloc>()
                                      .createDriverNote();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
