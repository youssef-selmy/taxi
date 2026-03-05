import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/blocs/taxi_order_detail.bloc.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_user_profile.dart';

class TaxiOrderCustomersAndDriverBox extends StatelessWidget {
  const TaxiOrderCustomersAndDriverBox({super.key, this.borderLess = false});

  final bool borderLess;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
      builder: (context, state) {
        final order = state.orderDetailResponse.data;

        return AppClickableCard(
          type: ClickableCardType.elevated,
          elevation: BetterShadow.shadow8,
          padding: borderLess ? EdgeInsets.all(0) : EdgeInsets.all(16),
          borderLess: borderLess,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LargeHeader(title: context.tr.customersDriverDetails),
              const SizedBox(height: 16),

              //Customer
              TaxiOrderUserProfile(
                title: context.tr.customer,
                imgUrl: order?.rider.imageUrl,
                name: order?.rider.fullName ?? '',
                mobileNumber: order?.rider.mobileNumber ?? '16505551234',
                countryCode: null,
              ),

              const Divider(height: 32),
              //Driver
              TaxiOrderUserProfile(
                title: context.tr.driver,
                imgUrl: order?.driver?.imageUrl,
                name: order?.driver?.fullName ?? '',
                mobileNumber:
                    order?.driver?.mobileNumber.formatPhoneNumber(null) ?? '-',
              ),
            ],
          ),
        );
      },
    );
  }
}
