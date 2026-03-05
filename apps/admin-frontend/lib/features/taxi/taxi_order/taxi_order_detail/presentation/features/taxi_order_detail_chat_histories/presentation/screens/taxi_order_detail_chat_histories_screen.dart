import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/presentation/blocs/taxi_order_detail_chat_histories.cubit.dart';

class TaxiOrderDetailChatHistoriesScreen extends StatelessWidget {
  const TaxiOrderDetailChatHistoriesScreen({
    super.key,
    required this.taxiOrderId,
  });

  final String taxiOrderId;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaxiOrderDetailChatHistoriesBloc()..onStarted(taxiOrderId),
      child:
          BlocBuilder<
            TaxiOrderDetailChatHistoriesBloc,
            TaxiOrderDetailChatHistoriesState
          >(
            builder: (context, state) {
              final conversations = state.taxiOrderConversationState.data;
              return Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: kBorder(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: LargeHeader(title: context.tr.chatHistory),
                    ),
                    if (conversations?.order.chatHistories.isNotEmpty ?? true)
                      Expanded(
                        child: Skeletonizer(
                          enabled: state.taxiOrderConversationState.isLoading,
                          enableSwitchAnimation: true,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            itemCount:
                                state.taxiOrderConversationState.isLoading
                                ? 4
                                : conversations?.order.chatHistories.length ??
                                      0,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final conversation =
                                  state.taxiOrderConversationState.isLoading
                                  ? mockConversation1
                                  : conversations!.order.chatHistories[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: ChatBubble(
                                  message: conversation.content,
                                  isMe: !conversation.sentByDriver,
                                  time: conversation.sentAt,
                                  avatar: conversation.sentByDriver
                                      ? conversations
                                            ?.order
                                            .driver
                                            ?.media
                                            ?.address
                                      : conversations
                                            ?.order
                                            .rider
                                            ?.media
                                            ?.address,
                                  name: conversation.sentByDriver
                                      ? conversations?.order.driver?.fullName
                                      : conversations?.order.rider?.firstName,
                                ),
                              );
                            },
                          ),
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
