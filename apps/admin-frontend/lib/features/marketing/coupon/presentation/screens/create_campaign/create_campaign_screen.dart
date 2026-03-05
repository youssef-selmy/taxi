import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/blocs/create_campaign.cubit.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/screens/create_campaign/pages/create_campaign_coupon_settings_page.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/screens/create_campaign/pages/create_campaign_details_page.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/screens/create_campaign/pages/create_campaign_target_users_page.dart';

@RoutePage()
class CreateCampaignScreen extends StatelessWidget {
  const CreateCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCampaignBloc(),
      child: BlocListener<CreateCampaignBloc, CreateCampaignState>(
        listener: (context, state) {
          if (state.networkStateSave.isLoaded) {
            context.router.replace(const CampaignListRoute());
          }
        },
        child: Container(
          color: context.colors.surface,
          margin: EdgeInsets.only(top: context.responsive(16, lg: 48)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: context.pagePaddingHorizontal,
                child: PageHeader(
                  title: context.tr.createCampaign,
                  subtitle: context.tr.createCampaignSubtitle,
                  showBackButton: true,
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: context.pagePaddingHorizontal,
                child: BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
                  buildWhen: (previous, current) =>
                      previous.selectedPage != current.selectedPage,
                  builder: (context, state) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: AppHorizontalStepIndicator(
                        connectorStyle: ConnectorStyle.line,
                        style: StepIndicatorItemStyle.circular,
                        items: [
                          StepIndicatorItem(
                            label: context.tr.details,
                            value: 0,
                            description: context.tr.detailsSubtitle,
                          ),
                          StepIndicatorItem(
                            label: context.tr.targetUsers,
                            value: 1,
                            description: context.tr.targetUsersSubtitle,
                          ),
                          StepIndicatorItem(
                            label: context.tr.couponSettings,
                            value: 2,
                            description: context.tr.couponSettingsSubtitle,
                          ),
                          // StepIndicatorItem(
                          //   label: context.tr.sendingOptions,
                          //   value: 3,
                          //   description: context.tr.sendingOptionsSubtitle,
                          // ),
                        ],
                        selectedStep: state.selectedPage,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
                  builder: (context, state) {
                    return switch (state.selectedPage) {
                      0 => const CreateCampaignDetailsPage(),
                      1 => const CreateCampaignTargetUsers(),
                      2 => const CreateCampaignCouponSettings(),
                      // 3 => const CreateCampaignSendingOptionsPage(),
                      _ => const CreateCampaignDetailsPage(),
                    };
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
