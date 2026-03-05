import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/presentation/blocs/taxi_order_detail_notes.cubit.dart';

class TaxiOrderDetailNotesScreen extends StatelessWidget {
  final bool borderless;
  const TaxiOrderDetailNotesScreen({super.key, this.borderless = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrderDetailNotesBloc, TaxiOrderDetailNotesState>(
      builder: (context, stateTaxi) {
        final notes = stateTaxi.orderDetailNotesState.data;
        return AppClickableCard(
          borderLess: borderless,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: LargeHeader(title: context.tr.notes),
              ),
              Expanded(
                child: Skeletonizer(
                  enabled: stateTaxi.orderDetailNotesState.isLoading,
                  enableSwitchAnimation: true,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        itemCount: stateTaxi.orderDetailNotesState.isLoading
                            ? 5
                            : notes?.taxiOrderNotes.nodes.length ?? 0,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final note = stateTaxi.orderDetailNotesState.isLoading
                              ? mockNote1
                              : notes?.taxiOrderNotes.nodes[index];
                          return ChatBubble(
                            message: note!.note,
                            isMe: state.profile?.id == note.staff.id,
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppSendMessage(
                  sendState: stateTaxi.createOrderNoteState,
                  onChanged: (value) {
                    context.read<TaxiOrderDetailNotesBloc>().onNoteChange(
                      value,
                    );
                  },
                  onSend: (message) {
                    context.read<TaxiOrderDetailNotesBloc>().createNote();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
