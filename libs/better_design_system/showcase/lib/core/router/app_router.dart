import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/features/activity_log/screens/activity_log_screen.dart';
import 'package:better_design_showcase/features/accordion/screens/accordion_screen.dart';
import 'package:better_design_showcase/features/avatar/presentation/screens/avatar_screen.dart';
import 'package:better_design_showcase/features/badge/screens/badge_screen.dart';
import 'package:better_design_showcase/features/blocks/screens/blocks_screen.dart';
import 'package:better_design_showcase/features/breadcrumb/screens/breadcrumb_screen.dart';
import 'package:better_design_showcase/features/button/screens/button_screen.dart';
import 'package:better_design_showcase/features/chart/screens/chart_screen.dart';
import 'package:better_design_showcase/features/checkbox/screens/checkbox_screen.dart';
import 'package:better_design_showcase/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:better_design_showcase/features/date_and_time_picker/screens/date_and_time_picker_screen.dart';
import 'package:better_design_showcase/features/docs/screens/docs_screen.dart';
import 'package:better_design_showcase/features/dropdown/screens/dropdown_screen.dart';
import 'package:better_design_showcase/features/divider/screens/divider_screen.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/screens/ecommerce_screen.dart';
import 'package:better_design_showcase/features/file_upload/screens/file_upload_screen.dart';
import 'package:better_design_showcase/features/fintech/presentation/screens/fintech_analytics_screen.dart';
import 'package:better_design_showcase/features/fintech/presentation/screens/fintech_card_screen.dart';
import 'package:better_design_showcase/features/fintech/presentation/screens/fintech_home_screen.dart';
import 'package:better_design_showcase/features/fintech/presentation/screens/fintech_profile_screen.dart';
import 'package:better_design_showcase/features/fintech/presentation/screens/fintech_screen.dart';
import 'package:better_design_showcase/features/fintech/presentation/screens/fintech_transfer_screen.dart';
import 'package:better_design_showcase/features/fintech/presentation/screens/fintech_transfer_successfully_screen.dart';
import 'package:better_design_showcase/features/home/presentation/screens/home_screen.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/screens/hr_platform_screen.dart';
import 'package:better_design_showcase/features/notification/screens/notification_screen.dart';
import 'package:better_design_showcase/features/icon_container/screens/icon_container_screen.dart';
import 'package:better_design_showcase/features/input_component/screens/input_component_screen.dart';
import 'package:better_design_showcase/features/list_item_cards/screens/list_item_cards_screen.dart';
import 'package:better_design_showcase/features/modal/screens/modal_screen.dart';
import 'package:better_design_showcase/features/pagination/screens/pagination_screen.dart';
import 'package:better_design_showcase/features/pin_input/screens/pin_input_screen.dart';
import 'package:better_design_showcase/features/sales_and_marketing/presentation/screens/sales_and_marketing_screen.dart';
import 'package:better_design_showcase/features/snackbar/screens/snackbar_screen.dart';
import 'package:better_design_showcase/features/switch_toggle/screens/switch_toggle_screen.dart';
import 'package:better_design_showcase/features/sidebar/screens/sidebar_screen.dart';
import 'package:better_design_showcase/features/step_indicator/screens/step_indicator_screen.dart';
import 'package:better_design_showcase/features/table/screens/table_screen.dart';
import 'package:better_design_showcase/features/templates/presentation/screens/templates_screen.dart';
import 'package:better_design_showcase/features/toast_massage/screens/toast_massage_screen.dart';
import 'package:better_design_showcase/features/progress_bar/screens/progress_bar_screen.dart';
import 'package:better_design_showcase/features/rating/screens/rating_screen.dart';
import 'package:better_design_showcase/features/radio/screens/radio_screen.dart';
import 'package:better_design_showcase/features/slider/screens/slider_screen.dart';
import 'package:better_design_showcase/features/switch/screens/switch_screen.dart';
import 'package:better_design_showcase/features/tag/screens/tag_screen.dart';
import 'package:better_design_showcase/features/tooltip/screens/tooltip_screen.dart';
import 'package:better_design_showcase/features/text_area/screens/text_area_screen.dart';
import 'package:better_design_showcase/features/text_input/screens/text_input_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Dialog|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: DashboardRoute.page,
      path: '/',
      children: [
        AutoRoute(page: HomeRoute.page, initial: true, path: 'home'),
        AutoRoute(page: TemplatesRoute.page, path: 'templates'),
        AutoRoute(page: BlocksRoute.page, path: 'blocks'),
        AutoRoute(page: DocsRoute.page, path: 'docs'),
        AutoRoute(page: AvatarRoute.page, path: 'avatar'),
        AutoRoute(page: ButtonRoute.page, path: 'button'),
        AutoRoute(page: BadgeRoute.page, path: 'badge'),
        AutoRoute(page: BreadcrumbRoute.page, path: 'breadcrumb'),
        AutoRoute(page: SnackbarRoute.page, path: 'snackbar'),
        AutoRoute(page: ChartRoute.page, path: 'chart'),
        AutoRoute(page: ActivityLogRoute.page, path: 'activity-log'),
        AutoRoute(page: SwitchToggleRoute.page, path: 'switch-toggle'),
        AutoRoute(page: ToastMassageRoute.page, path: 'toast-massage'),
        AutoRoute(page: NotificationRoute.page, path: 'notification'),
        AutoRoute(page: SliderRoute.page, path: 'slider'),
        AutoRoute(page: ProgressBarRoute.page, path: 'progress-bar'),
        AutoRoute(page: TagRoute.page, path: 'tag'),
        AutoRoute(page: CheckboxRoute.page, path: 'checkbox'),
        AutoRoute(page: DropdownRoute.page, path: 'dropdown'),
        AutoRoute(page: IconContainerRoute.page, path: 'iconContainer'),
        AutoRoute(page: PinInputRoute.page, path: 'pinInput'),
        AutoRoute(page: DividerRoute.page, path: 'divider'),
        AutoRoute(page: FileUploadRoute.page, path: 'fileUpload'),
        AutoRoute(page: ListItemCardsRoute.page, path: 'listItemCards'),
        AutoRoute(page: InputComponentRoute.page, path: 'inputComponent'),
        AutoRoute(page: TextAreaRoute.page, path: 'textArea'),
        AutoRoute(page: PaginationRoute.page, path: 'pagination'),
        AutoRoute(page: StepIndicatorRoute.page, path: 'stepIndicator'),
        AutoRoute(page: SidebarRoute.page, path: 'sidebar'),
        AutoRoute(page: TextInputRoute.page, path: 'textInput'),
        AutoRoute(page: ModalRoute.page, path: 'modal'),
        AutoRoute(page: TableRoute.page, path: 'table'),
        AutoRoute(
          page: DateAndTimePickerRoute.page,
          path: 'Date-And-Time-Picker',
        ),
        AutoRoute(page: SwitchRoute.page, path: 'switch'),
        AutoRoute(page: RadioRoute.page, path: 'radio'),
        AutoRoute(page: TooltipRoute.page, path: 'tooltip'),
        AutoRoute(page: EcommerceRoute.page, path: 'ecommerce'),
        AutoRoute(page: AccordionRoute.page, path: 'accordion'),
        AutoRoute(page: RatingRoute.page, path: 'rating'),
        AutoRoute(
          page: FintechRoute.page,
          path: 'fintech',
          children: [
            AutoRoute(page: FintechHomeRoute.page, path: 'home'),
            AutoRoute(page: FintechCardRoute.page, path: 'card'),
            AutoRoute(page: FintechAnalyticsRoute.page, path: 'analytics'),
            AutoRoute(page: FintechProfileRoute.page, path: 'profile'),
            AutoRoute(page: FintechTransferRoute.page, path: 'transfer'),
            AutoRoute(
              page: FintechTransferSuccessfullyRoute.page,
              path: 'transfer-successfully',
            ),
          ],
        ),
        AutoRoute(page: HrPlatformRoute.page, path: 'hr-platform'),
        AutoRoute(
          page: SalesAndMarketingRoute.page,
          path: 'sales-and-marketing',
        ),
      ],
    ),
  ];
}
