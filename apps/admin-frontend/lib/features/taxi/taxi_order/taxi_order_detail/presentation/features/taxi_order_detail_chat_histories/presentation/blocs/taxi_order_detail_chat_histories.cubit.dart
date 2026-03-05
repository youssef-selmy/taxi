import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/data/graphql/taxi_order_detail_chat_histories.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/data/repositories/taxi_order_detail_chat_histories_repository.dart';

part 'taxi_order_detail_chat_histories.state.dart';
part 'taxi_order_detail_chat_histories.cubit.freezed.dart';

class TaxiOrderDetailChatHistoriesBloc
    extends Cubit<TaxiOrderDetailChatHistoriesState> {
  final TaxiOrderDetailChatHistoriesRepository
  _taxiOrderDetailChatHistoryRepository =
      locator<TaxiOrderDetailChatHistoriesRepository>();

  TaxiOrderDetailChatHistoriesBloc()
    // ignore: prefer_const_constructors
    : super(TaxiOrderDetailChatHistoriesState());

  void onStarted(String taxiOrderId) {
    _fetchTaxiOrderDetailChatHistory(taxiOrderId);
  }

  Future<void> _fetchTaxiOrderDetailChatHistory(String taxiOrderId) async {
    emit(
      state.copyWith(taxiOrderConversationState: const ApiResponse.loading()),
    );
    final taxiOrderDetailChatHistoryOrError =
        await _taxiOrderDetailChatHistoryRepository
            .getTaxiOrderDetailChatHistories(id: taxiOrderId);

    emit(
      state.copyWith(
        taxiOrderConversationState: taxiOrderDetailChatHistoryOrError,
      ),
    );
  }
}
