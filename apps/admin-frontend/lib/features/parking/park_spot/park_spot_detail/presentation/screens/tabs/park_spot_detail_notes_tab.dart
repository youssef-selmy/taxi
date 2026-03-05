import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_notes.cubit.dart';

class ParkSpotDetailNotesTab extends StatelessWidget {
  final String parkSpotId;

  const ParkSpotDetailNotesTab({super.key, required this.parkSpotId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkSpotDetailNotesBloc()..onStarted(parkSpotId: parkSpotId),
      child: BlocBuilder<ParkSpotDetailNotesBloc, ParkSpotDetailNotesState>(
        builder: (context, stateNotes) {
          final notes = stateNotes.parkSpotNotesState.data;
          return Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: kBorder(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: LargeHeader(title: context.tr.notes),
                ),
                const Divider(height: 1),
                Expanded(
                  child: Skeletonizer(
                    enabled: stateNotes.parkSpotNotesState.isLoading,
                    enableSwitchAnimation: true,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          child: SizedBox(
                            height: 450,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: stateNotes.parkSpotNotesState.isLoading
                                  ? 5
                                  : notes?.parkSpotNotes.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final note =
                                    stateNotes.parkSpotNotesState.isLoading
                                    ? mockParkingNote1
                                    : notes?.parkSpotNotes[index];
                                return note?.toChatBubble(
                                  context,
                                  state.profile!.id,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppSendMessage(
                    onSend: (message) {
                      context.read<ParkSpotDetailNotesBloc>().onSubmitNote();
                    },
                    sendState: stateNotes.createOrderNoteState,
                    onChanged: context
                        .read<ParkSpotDetailNotesBloc>()
                        .onNoteChanged,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
