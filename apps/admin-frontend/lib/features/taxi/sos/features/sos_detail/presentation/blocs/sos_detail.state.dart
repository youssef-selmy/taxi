part of 'sos_detail.cubit.dart';

@freezed
sealed class SosDetailState with _$SosDetailState {
  const factory SosDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$distressSignalDetail> distressSignalDetail,
    String? sosId,
  }) = _SosDetailState;
}
