import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_sessions.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_sessions_repository.dart';

part 'shop_detail_sessions.state.dart';
part 'shop_detail_sessions.cubit.freezed.dart';

class ShopDetailSessionsBloc extends Cubit<ShopDetailSessionsState> {
  final ShopDetailSessionsRepository _shopDetailSessionsRepository =
      locator<ShopDetailSessionsRepository>();

  ShopDetailSessionsBloc() : super(ShopDetailSessionsState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    _fetchSessions();
  }

  @override
  Future<void> close() {
    locator.unregister<ShopDetailSessionsRepository>();
    return super.close();
  }

  Future<void> _fetchSessions() async {
    emit(state.copyWith(loginSessionsState: ApiResponse.loading()));
    final sessionsOrError = await _shopDetailSessionsRepository.getSessions(
      ownerId: state.shopId!,
    );
    final sessionsState = sessionsOrError;
    emit(state.copyWith(loginSessionsState: sessionsState));
  }

  void onTerminateSession(String sessionId) async {
    final terminateSessionOrError = await _shopDetailSessionsRepository
        .terminateSession(sessionId: sessionId);
    if (terminateSessionOrError.isLoaded) {
      _fetchSessions();
    }
  }
}
