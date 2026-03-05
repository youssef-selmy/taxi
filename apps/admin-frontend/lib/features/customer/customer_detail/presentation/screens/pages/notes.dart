import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/customer_notes.cubit.dart';

class CustomerDetailsNotes extends StatelessWidget {
  final String customerId;

  const CustomerDetailsNotes({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerNotesBloc()..onStarted(customerId: customerId),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: LargeHeader(title: context.tr.notes),
            ),
            const Divider(height: 1),
            Expanded(
              child: BlocBuilder<CustomerNotesBloc, CustomerNotesState>(
                builder: (context, state) {
                  final me = context.read<AuthBloc>().state.profile!;
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Skeletonizer(
                      enabled: state.notesState.isLoading,
                      child: ListView.separated(
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          final note = state.notesState.data?[index];
                          return ChatBubble(
                            message: note?.note ?? "",
                            isMe: note?.createdBy.id == me.id,
                            time: note?.createdAt ?? DateTime.now(),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: state.notesState.data?.length ?? 5,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppSendMessage(
                onSend: (message) async {
                  await context.read<CustomerNotesBloc>().onAddNote();
                },
                onChanged: (p0) =>
                    context.read<CustomerNotesBloc>().onNoteChanged(note: p0),
              ),
              // child: Row(
              //   children: [
              //     Expanded(
              //       child: BlocBuilder<CustomerNotesBloc, CustomerNotesState>(
              //         builder: (context, state) {
              //           return AppTextField(
              //             controller: _noteController,
              //             initialValue: state.note,
              //             hint: "Add a note",
              //             onChanged: (p0) => context.read<CustomerNotesBloc>().onNoteChanged(note: p0),
              //           );
              //         },
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 16,
              //     ),
              //     ElevatedButton(
              //       onPressed: () async {
              //         await context.read<CustomerNotesBloc>().onAddNote();
              //         _noteController.clear();
              //       },
              //       child: const Icon(BetterIcons.send),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
