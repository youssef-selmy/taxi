import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_detail/data/graphql/shop_support_request_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_detail/data/repositories/shop_support_request_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_support_request_detail.state.dart';
part 'shop_support_request_detail.cubit.freezed.dart';

class ShopSupportRequestDetailBloc
    extends Cubit<ShopSupportRequestDetailState> {
  final ShopSupportRequestDetailRepository _supportReuestDetailRepository =
      locator<ShopSupportRequestDetailRepository>();

  ShopSupportRequestDetailBloc()
    : super(ShopSupportRequestDetailState.initial());

  void onStarted(String id) {
    emit(state.copyWith(id: id));
    _fetchSupportRequestDetail();
  }

  Future<void> _fetchSupportRequestDetail() async {
    emit(state.copyWith(supportRequestState: const ApiResponse.loading()));

    final supportRequestDetailOrError = await _supportReuestDetailRepository
        .getSupportRequest(id: state.id!);

    emit(state.copyWith(supportRequestState: supportRequestDetailOrError));
  }

  Future<void> onAddComment() async {
    if (state.comment == null || state.comment!.isEmpty) {
      return;
    }
    emit(
      state.copyWith(
        createShopSupportRequestCommentState: const ApiResponse.loading(),
      ),
    );
    final createCommentResponse = await _supportReuestDetailRepository
        .addComment(
          input: Input$CreateShopSupportRequestCommentInput(
            supportRequestId: state.id!,
            comment: state.comment!,
          ),
        );
    emit(
      state.copyWith(
        createShopSupportRequestCommentState: createCommentResponse,
      ),
    );
    if (createCommentResponse.isLoaded) {
      emit(state.copyWith(comment: null));
      _fetchSupportRequestDetail();
    }
    emit(
      state.copyWith(
        createShopSupportRequestCommentState: ApiResponse.initial(),
      ),
    );
  }

  Future<void> onAddAssignSupportRequest() async {
    await _supportReuestDetailRepository.assignToStaffs(
      input: Input$AssignShopSupportRequestInput(
        supportRequestId: state.id!,
        staffIds: state.staffsId!,
      ),
    );

    _fetchSupportRequestDetail();
  }

  Future<void> onStatusChanged(Enum$ComplaintStatus? status) async {
    await _supportReuestDetailRepository.updateStatus(
      input: Input$ChangeShopSupportRequestStatusInput(
        supportRequestId: state.id!,
        status: status!,
      ),
    );
    _fetchSupportRequestDetail();
  }

  void onCommentChanged(String comment) =>
      emit(state.copyWith(comment: comment));

  void onAssignChanged(List<Fragment$staffListItem> listOperator) {
    emit(state.copyWith(staffsId: listOperator.map((e) => e.id).toList()));
    if (state.staffsId != null && state.staffsId!.isNotEmpty) {
      onAddAssignSupportRequest();
    }
  }
}
