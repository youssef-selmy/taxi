import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/blocs/driver_payout_session_detail.cubit.dart';

class ExportToCsvButton extends StatelessWidget {
  const ExportToCsvButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPayoutSessionDetailBloc>();
    return AppOutlinedButton(
      onPressed: () async {
        final urlOrError = await bloc.exportPayoutToCSV();
        urlOrError.fold(
          (l, {failure}) {
            context.showToast(l, type: SemanticColor.error);
          },
          (url) {
            launchUrlString(url);
          },
        );
      },
      text: context.tr.exportToCSV,
    );
  }
}
