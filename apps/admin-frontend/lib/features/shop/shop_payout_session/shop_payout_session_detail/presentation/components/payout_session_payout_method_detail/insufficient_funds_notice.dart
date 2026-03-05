import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/presentation/blocs/shop_payout_session_detail.cubit.dart';

class InsufficientFundsNotice extends StatelessWidget {
  const InsufficientFundsNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ShopPayoutSessionDetailBloc,
      ShopPayoutSessionDetailState
    >(
      builder: (context, state) {
        if (state.isFundsSufficient) return const SizedBox();
        return Row(
          children: [
            AppTag(
              text: context.tr.insufficientFunds,
              color: SemanticColor.error,
            ),
            const SizedBox(width: 16),
            AppTextButton(
              text: context.tr.addFunds,
              onPressed: () {
                launchUrlString(
                  "https://dashboard.stripe.com/balance/overview",
                );
              },
            ),
          ],
        );
      },
    );
  }
}
