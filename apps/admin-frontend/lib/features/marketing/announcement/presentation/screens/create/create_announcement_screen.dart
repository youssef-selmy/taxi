import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/blocs/create_announcement.cubit.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/screens/create/pages/details.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/screens/create/pages/sending_options.dart';

@RoutePage()
class CreateAnnouncementScreen extends StatelessWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAnnouncementBloc(),
      child: BlocListener<CreateAnnouncementBloc, CreateAnnouncementState>(
        listener: (context, state) {
          if (state.networkStateSave.isLoaded) {
            context.showToast(
              context.tr.savedSuccessfully,
              type: SemanticColor.success,
            );
            context.router.replace(AnnouncementListRoute());
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(color: context.colorScheme.surface),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Padding(
                padding: context.pagePaddingHorizontal,
                child: PageHeader(
                  title: context.tr.createAnnouncement,
                  subtitle: context.tr.createAnnouncementSubtitle,
                  showBackButton: true,
                  onBackButtonPressed: () =>
                      context.router.replace(AnnouncementListRoute()),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: context.pagePaddingHorizontal,
                child:
                    BlocBuilder<
                      CreateAnnouncementBloc,
                      CreateAnnouncementState
                    >(
                      buildWhen: (previous, current) =>
                          previous.selectedPage != current.selectedPage,
                      builder: (context, state) {
                        return AppHorizontalStepIndicator(
                          connectorStyle: ConnectorStyle.line,
                          style: StepIndicatorItemStyle.circular,
                          items: [
                            StepIndicatorItem(
                              label: context.tr.details,
                              value: 0,
                              description:
                                  context.tr.createAnnouncementDetailsSubtitle,
                            ),
                            StepIndicatorItem(
                              label: context.tr.sendingOptions,
                              value: 1,
                              description: context
                                  .tr
                                  .createAnnouncementSendingOptionsSubtitle,
                            ),
                          ],
                          selectedStep: state.selectedPage,
                        );
                      },
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child:
                    BlocBuilder<
                      CreateAnnouncementBloc,
                      CreateAnnouncementState
                    >(
                      builder: (context, state) {
                        return IndexedStack(
                          index: state.selectedPage,
                          children: const [
                            CreateAnnouncementDetailsPage(),
                            CreateAnnouncementSendingOptionsPage(),
                          ],
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
