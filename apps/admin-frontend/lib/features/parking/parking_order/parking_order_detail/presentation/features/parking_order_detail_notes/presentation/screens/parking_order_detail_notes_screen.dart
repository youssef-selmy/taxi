import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/presentation/blocs/parking_order_detail_notes.cubit.dart';

class ParkingOrderDetailNotesScreen extends StatelessWidget {
  const ParkingOrderDetailNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingOrderDetailNotesBloc(),
      child:
          BlocBuilder<
            ParkingOrderDetailNotesBloc,
            ParkingOrderDetailNotesState
          >(
            builder: (context, stateParkingOrderNotes) {
              final notes = stateParkingOrderNotes.parkingOrderNotesState.data;
              return SafeArea(
                top: false,
                child: Container(
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
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              child: Skeletonizer(
                                enabled: stateParkingOrderNotes
                                    .parkingOrderNotesState
                                    .isLoading,
                                enableSwitchAnimation: true,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount:
                                      stateParkingOrderNotes
                                          .parkingOrderNotesState
                                          .isLoading
                                      ? 5
                                      : notes?.parkOrder.notes.length ?? 0,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16),
                                  itemBuilder: (context, index) {
                                    final note = notes?.parkOrder.notes[index];
                                    return ChatBubble(
                                      message: note?.note ?? '',
                                      isMe: state.profile!.id == note?.staff.id,
                                      time: note?.createdAt ?? DateTime.now(),
                                      avatar: note?.staff.media?.address,
                                      name: note?.staff.firstName,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: AppSendMessage(
                          onSend: (message) {
                            context
                                .read<ParkingOrderDetailNotesBloc>()
                                .onSendNote();
                          },
                          sendState:
                              stateParkingOrderNotes.createOrderNoteState,
                          onChanged: (value) {
                            context
                                .read<ParkingOrderDetailNotesBloc>()
                                .onNoteChanged(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
