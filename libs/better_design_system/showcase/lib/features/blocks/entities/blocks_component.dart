import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/router/app_router.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';

class BlocksComponent {
  final AssetGenImage image;
  final String componentName;
  final int blockCount;
  final PageRouteInfo route;

  const BlocksComponent({
    required this.image,
    required this.componentName,
    required this.blockCount,
    required this.route,
  });
}

final List<BlocksComponent> blocks = <BlocksComponent>[
  BlocksComponent(
    image: Assets.images.blocksComponent.avatarComponent,
    componentName: 'Avatar',
    blockCount: 3,
    route: AvatarRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.buttonComponent,
    componentName: 'Button',
    blockCount: 5,
    route: ButtonRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.badgeComponent,
    componentName: 'Badge',
    blockCount: 3,
    route: BadgeRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.breadCrumbsComponent,
    componentName: 'Breadcrumb',
    blockCount: 2,
    route: BreadcrumbRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.snackbarComponent,
    componentName: 'Snackbar',
    blockCount: 2,
    route: SnackbarRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.chartsComponent,
    componentName: 'Chart',
    blockCount: 4,
    route: ChartRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.activityLogComponent,
    componentName: 'Activity Log',
    blockCount: 1,
    route: ActivityLogRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.switchToggleComponent,
    componentName: 'Switch Toggle',
    blockCount: 3,
    route: SwitchToggleRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.toastMassageComponent,
    componentName: 'Toast Massage',
    blockCount: 4,
    route: ToastMassageRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.notificationComponent,
    componentName: 'Notification',
    blockCount: 2,
    route: NotificationRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.sliderComponent,
    componentName: 'Slider',
    blockCount: 3,
    route: SliderRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.progressBarComponent,
    componentName: 'Progress Bar',
    blockCount: 3,
    route: ProgressBarRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.accordionComponent,
    componentName: 'Accordion',
    blockCount: 2,
    route: AccordionRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.ratingComponent,
    componentName: 'Rating',
    blockCount: 4,
    route: RatingRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.tagComponent,
    componentName: 'Tag',
    blockCount: 3,
    route: TagRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.checkboxComponent,
    componentName: 'Checkbox',
    blockCount: 3,
    route: CheckboxRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.dateAndTimePickerComponent,
    componentName: 'Date & Time Picker',
    blockCount: 2,
    route: DateAndTimePickerRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.dropdownComponent,
    componentName: 'Dropdown',
    blockCount: 4,
    route: DropdownRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.switchComponent,
    componentName: 'Switch',
    blockCount: 2,
    route: SwitchRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.radioComponent,
    componentName: 'Radio',
    blockCount: 2,
    route: RadioRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.tooltipComponent,
    componentName: 'Tooltip',
    blockCount: 3,
    route: TooltipRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.dividerComponent,
    componentName: 'Divider',
    blockCount: 2,
    route: DividerRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.fileUploadComponent,
    componentName: 'File Upload',
    blockCount: 3,
    route: FileUploadRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.iconContainerComponent,
    componentName: 'Icon Container',
    blockCount: 0,
    route: IconContainerRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.pinInputComponent,
    componentName: 'Pin Input',
    blockCount: 1,
    route: PinInputRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.inputComponent,
    componentName: 'Input Component',
    blockCount: 0,
    route: InputComponentRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.listItemCardComponent,
    componentName: 'List Item Cards',
    blockCount: 2,
    route: ListItemCardsRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.textAreaComponent,
    componentName: 'Text Area',
    blockCount: 1,
    route: TextAreaRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.paginationComponent,
    componentName: 'Pagination',
    blockCount: 1,
    route: PaginationRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.stepIndicatorComponent,
    componentName: 'Step Indicator',
    blockCount: 3,
    route: StepIndicatorRoute(),
  ),
  BlocksComponent(
    // Add the image asset for Sidebar ASAP --> sidebarComponent.
    image: Assets.images.blocksComponent.accordionComponent,
    componentName: 'Sidebar',
    blockCount: 1,
    route: SidebarRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.textInputComponent,
    componentName: 'Text Input',
    blockCount: 5,
    route: TextInputRoute(),
  ),
  BlocksComponent(
    image: Assets.images.blocksComponent.modalComponent,
    componentName: 'Modal',
    blockCount: 4,
    route: ModalRoute(),
  ),
  BlocksComponent(
    // Add the image asset for Table ASAP --> tableComponent.
    image: Assets.images.blocksComponent.accordionComponent,
    componentName: 'Table',
    blockCount: 3,
    route: TableRoute(),
  ),
];
