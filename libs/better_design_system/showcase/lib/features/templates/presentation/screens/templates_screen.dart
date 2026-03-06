import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/features/home/presentation/components/footer.dart';
import 'package:better_design_showcase/features/templates/presentation/components/ecommerce_list.dart';
import 'package:better_design_showcase/features/templates/presentation/components/fintech_list.dart';
import 'package:better_design_showcase/features/templates/presentation/components/hr_platform_list.dart';
import 'package:better_design_showcase/features/templates/presentation/components/sales_marketing_list.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

part 'templates_screen.desktop.dart';
part 'templates_screen.mobile.dart';

@RoutePage()
class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return context.responsive(
      const TemplatesScreenMobile(),
      xl: const TemplatesScreenDesktop(),
    );
  }
}
