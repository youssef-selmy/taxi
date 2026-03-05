import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/coupon/data/graphql/coupon.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/data/repositories/coupon_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'campaign_list.state.dart';
part 'campaign_list.cubit.freezed.dart';

class CampaignListBloc extends Cubit<CampaignListState> {
  final CouponRepository _couponRepository = locator<CouponRepository>();

  CampaignListBloc() : super(CampaignListState());

  void onStarted() {
    _getCampaigns();
  }

  Future<void> _getCampaigns() async {
    emit(state.copyWith(campaigns: const ApiResponse.loading()));
    final campaigns = await _couponRepository.getCampaigns(
      paging: state.paging,
      filter: Input$CampaignFilter(
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
      ),
      sorting: state.sort,
    );
    emit(state.copyWith(campaigns: campaigns));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _getCampaigns();
  }

  void onSearchQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _getCampaigns();
  }

  void refresh() {
    _getCampaigns();
  }
}
