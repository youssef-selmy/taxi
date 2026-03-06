import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/core/router/app_router.dart'
    hide ModalRoute;
import 'package:better_design_showcase/features/home/presentation/components/header.dart';
import 'package:better_design_showcase/features/home/presentation/components/theme_dropdown.dart';
import 'package:better_design_showcase/features/home/presentation/screens/home_screen.dart';
import 'package:better_design_showcase/features/templates/presentation/screens/templates_screen.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/top_bar_icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/navbar/navbar.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_item.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_option.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_style.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_screen.desktop.dart';
part 'dashboard_screen.mobile.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return context.responsive(
      const DashboardScreenMobile(),
      xl: const DashboardScreenDesktop(),
    );
  }
}
