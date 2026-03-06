import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/features/home/presentation/components/component_doc.dart';
import 'package:better_design_showcase/features/home/presentation/components/email_verification.dart';
import 'package:better_design_showcase/features/home/presentation/components/exchange.dart';
import 'package:better_design_showcase/features/home/presentation/components/footer.dart';
import 'package:better_design_showcase/features/home/presentation/components/horizontal_tab_bar.dart';
import 'package:better_design_showcase/features/home/presentation/components/login_otp.dart';
import 'package:better_design_showcase/features/home/presentation/components/message_list.dart';
import 'package:better_design_showcase/features/home/presentation/components/new_account.dart';
import 'package:better_design_showcase/features/home/presentation/components/new_customers.dart';
import 'package:better_design_showcase/features/home/presentation/components/notification_card.dart';
import 'package:better_design_showcase/features/home/presentation/components/notification_setting.dart';
import 'package:better_design_showcase/features/home/presentation/components/onboarding_calendar.dart';
import 'package:better_design_showcase/features/home/presentation/components/pricing_plans.dart';
import 'package:better_design_showcase/features/home/presentation/components/saved_actions.dart';
import 'package:better_design_showcase/features/home/presentation/components/spending_summary.dart';
import 'package:better_design_showcase/features/home/presentation/components/time_tracker.dart';
import 'package:better_design_showcase/features/home/presentation/components/user_access.dart';
import 'package:better_design_showcase/features/home/presentation/components/user_post.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
part 'home_screen.desktop.dart';
part 'home_screen.mobile.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return context.responsive(
      const HomeScreenMobile(),
      xl: const HomeScreenDesktop(),
    );
  }
}
