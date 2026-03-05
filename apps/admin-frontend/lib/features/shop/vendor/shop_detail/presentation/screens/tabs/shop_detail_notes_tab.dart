import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_notes.cubit.dart';

class ShopDetailNotesTab extends StatelessWidget {
  final String shopId;

  const ShopDetailNotesTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailNotesBloc()..onStarted(shopId: shopId),
      child: BlocBuilder<ShopDetailNotesBloc, ShopDetailNotesState>(
        builder: (context, stateNotes) {
          final notes = stateNotes.shopNotesState.data;
          return Container(
            margin: const EdgeInsets.only(bottom: 24),
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
                    enabled: stateNotes.shopNotesState.isLoading,
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
                              itemCount: stateNotes.shopNotesState.isLoading
                                  ? 5
                                  : notes?.shopNotes.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final note = stateNotes.shopNotesState.isLoading
                                    ? mockShopNote1
                                    : notes?.shopNotes[index];
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
                BlocBuilder<ShopDetailNotesBloc, ShopDetailNotesState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppSendMessage(
                        onSend: (comment) {
                          context.read<ShopDetailNotesBloc>().onSubmitNote();
                        },
                        sendState: state.createShopNoteState,
                        onChanged: context
                            .read<ShopDetailNotesBloc>()
                            .onNoteChanged,
                      ),
                    );
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
