import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/sos/features/sos_detail/presentation/blocs/sos_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/sos/features/sos_detail/presentation/widget/sos_detail_box_widget.dart';

@RoutePage()
class SosDetailScreen extends StatelessWidget {
  const SosDetailScreen({super.key, required this.sosId});

  final String sosId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SosDetailBloc()..onStarted(sosId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            PageHeader(
              showBackButton: true,
              title: context.tr.sosDetails,
              subtitle: context.tr.viewSosDetails,
            ),
            SizedBox(height: 16),
            SosDetailBox(),
          ],
        ),
      ),
    );
  }
}
