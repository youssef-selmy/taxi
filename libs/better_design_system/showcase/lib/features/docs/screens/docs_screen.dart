import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/features/docs/blocs/docs.cubit.dart';
import 'package:better_design_showcase/features/docs/components/docs_content.dart';
import 'package:better_design_showcase/features/docs/components/docs_sidebar.dart';
import 'package:better_design_showcase/features/docs/components/docs_table_of_contents.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/docs_custom_widget.dart';
part 'docs_screen.desktop.dart';
part 'docs_screen.mobile.dart';

@RoutePage()
class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocsCubit()..onStarted(),
      child: Material(
        child: context.responsive(
          const DocsScreenMobile(),
          xl: const DocsScreenDesktop(),
        ),
      ),
    );
  }
}
