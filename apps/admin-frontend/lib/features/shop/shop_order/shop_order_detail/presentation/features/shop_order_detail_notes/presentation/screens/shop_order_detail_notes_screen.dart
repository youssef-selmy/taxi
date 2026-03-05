import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_notes/presentation/blocs/shop_order_detail_notes.cubit.dart';

class ShopOrderDetailNotesScreen extends StatelessWidget {
  const ShopOrderDetailNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopOrderDetailNotesBloc(),
      child: BlocBuilder<ShopOrderDetailNotesBloc, ShopOrderDetailNotesState>(
        builder: (context, noteState) {
          final notes = noteState.shopOrderDetailNotesState.data;
          return Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: kBorder(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Column(
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
                    Expanded(
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authState) {
                          return Skeletonizer(
                            enabled:
                                noteState.shopOrderDetailNotesState.isLoading,
                            enableSwitchAnimation: true,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              child: SizedBox(
                                height: 450,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount:
                                      noteState
                                          .shopOrderDetailNotesState
                                          .isLoading
                                      ? 3
                                      : notes?.length ?? 0,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16),
                                  itemBuilder: (context, index) {
                                    final note =
                                        noteState
                                            .shopOrderDetailNotesState
                                            .isLoading
                                        ? mockShopOrderNote1
                                        : notes![index];
                                    return note.toChatBubble(
                                      context,
                                      authState.profile!.id,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppSendMessage(
                        onSend: (message) {
                          context
                              .read<ShopOrderDetailNotesBloc>()
                              .onSubmitNote();
                        },
                        sendState: noteState.createOrderNoteState,
                        onChanged: context
                            .read<ShopOrderDetailNotesBloc>()
                            .onNoteChanged,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
