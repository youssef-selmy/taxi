import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_taxi.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customer_complaints_taxi.state.dart';
part 'customer_complaints_taxi.cubit.freezed.dart';

@injectable
class CustomerComplaintsTaxiCubit extends Cubit<CustomerComplaintsTaxiState> {
  final CustomerComplaintsTaxiRepository _customerComplaintsTaxiRepository =
      locator<CustomerComplaintsTaxiRepository>();

  CustomerComplaintsTaxiCubit() : super(const CustomerComplaintsTaxiState());

  void onStarted({required String customerId}) {
    emit(state.copyWith(customerId: customerId));
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    emit(state.copyWith(complaintsResponse: const ApiResponse.loading()));
    final complaintsResponse = await _customerComplaintsTaxiRepository
        .getCustomerComplaintsTaxi(
          paging: state.paging,
          sorting: state.sortFields,
          filter: Input$TaxiSupportRequestFilter(
            request: Input$TaxiSupportRequestFilterOrderFilter(
              riderId: Input$IDFilterComparison(eq: state.customerId),
            ),
            requestedByDriver: Input$BooleanFieldComparison($is: false),
            status: state.filterStatus.isEmpty
                ? null
                : Input$ComplaintStatusFilterComparison(
                    $in: state.filterStatus,
                  ),
          ),
        );
    emit(state.copyWith(complaintsResponse: complaintsResponse));
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchComplaints();
  }

  void onStatusFilterChanged(List<Enum$ComplaintStatus> p1) {
    emit(state.copyWith(filterStatus: p1));
    _fetchComplaints();
  }

  void onSortingChanged(List<Input$TaxiSupportRequestSort> p1) {
    emit(state.copyWith(sortFields: p1));
    _fetchComplaints();
  }

  void onStatusChanged(String id, Enum$ComplaintStatus? p0) {}
}
