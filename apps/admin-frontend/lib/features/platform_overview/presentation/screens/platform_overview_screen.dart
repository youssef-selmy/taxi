import 'package:admin_frontend/core/components/atoms/copyright_notice/copyright_notice.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_cart_bar_card.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_header.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_pending_requests_card.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_support_requests_card.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_table.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_top_stat_cards.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
part 'platform_overview_screen.desktop.dart';
part 'platform_overview_screen.mobile.dart';

@RoutePage()
class PlatformOverviewScreen extends StatelessWidget {
  const PlatformOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlatformOverviewCubit()..onStarted(),
      child: context.responsive(
        const PlatformOverviewScreenMobile(),
        xl: const PlatformOverviewScreenDesktop(),
      ),
    );
  }
}
