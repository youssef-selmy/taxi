part of 'sessions.cubit.dart';

@freezed
sealed class SessionsState with _$SessionsState {
  const factory SessionsState({
    String? customerId,
    required ApiResponse<List<Fragment$customerSession>> networkState,
  }) = _SessionsState;
}
