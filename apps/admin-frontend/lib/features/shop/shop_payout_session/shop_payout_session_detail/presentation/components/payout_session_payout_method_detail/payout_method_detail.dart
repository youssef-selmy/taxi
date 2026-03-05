import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/presentation/blocs/shop_payout_session_detail.cubit.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_method_detail.desktop.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_method_detail.mobile.dart';

class PayoutMethodDetail extends StatelessWidget {
  const PayoutMethodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ShopPayoutSessionDetailBloc,
      ShopPayoutSessionDetailState
    >(
      builder: (context, state) {
        if (state.selectedPayoutMethodState.data == null) {
          return const SizedBox();
        }
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: context.responsive(
              const PayoutMethodDetailMobile(),
              lg: const PayoutMethodDetailDesktop(),
            ),
          ),
        );
      },
    );
  }
}
