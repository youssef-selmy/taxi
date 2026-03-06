import 'package:better_design_system/atoms/banner/banner.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'soft', type: AppBanner)
Widget softAppBanner(BuildContext context) {
  return _getAppBanner(context);
}

@UseCase(name: 'outline', type: AppBanner)
Widget outlineAppBanner(BuildContext context) {
  return _getAppBanner(context, style: BannerStyle.outline);
}

@UseCase(name: 'fill', type: AppBanner)
Widget fillAppBanner(BuildContext context) {
  return _getAppBanner(context, style: BannerStyle.fill);
}

Widget _getAppBanner(
  BuildContext context, {
  BannerStyle style = BannerStyle.soft,
}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30,
        children: [
          AppBanner(
            title: 'Title',
            subtitle: 'Description',
            onClosed: () {},
            type: BannerType.error,
            style: style,
            actions: [
              AppBannerAction(title: 'Cancel', onPressed: () {}),
              AppBannerAction(title: 'Confirm', onPressed: () {}),
            ],
            bannerAlign: context.knobs.object.dropdown(
              label: 'Align',
              options: BannerAlign.values,
              labelBuilder: (value) => value.name,
            ),
            bannerResponsive: context.knobs.object.dropdown(
              label: 'Responsive',
              options: BannerResponsive.values,
              labelBuilder: (value) => value.name,
            ),
            size: context.knobs.object.dropdown(
              label: 'size',
              options: BannerSize.values,
              labelBuilder: (value) => value.name,
            ),
          ),
          AppBanner(
            title: 'Title',
            subtitle: 'Description',
            onClosed: () {},
            type: BannerType.info,
            style: style,
            actions: [
              AppBannerAction(title: 'Cancel', onPressed: () {}),
              AppBannerAction(title: 'Confirm', onPressed: () {}),
            ],
            bannerAlign: context.knobs.object.dropdown(
              label: 'Align',
              options: BannerAlign.values,
              labelBuilder: (value) => value.name,
            ),
            bannerResponsive: context.knobs.object.dropdown(
              label: 'Responsive',
              options: BannerResponsive.values,
              labelBuilder: (value) => value.name,
            ),
            size: context.knobs.object.dropdown(
              label: 'size',
              options: BannerSize.values,
              labelBuilder: (value) => value.name,
            ),
          ),
          AppBanner(
            title: 'Title',
            subtitle: 'Description',
            onClosed: () {},

            type: BannerType.success,
            style: style,
            actions: [
              AppBannerAction(title: 'Cancel', onPressed: () {}),
              AppBannerAction(title: 'Confirm', onPressed: () {}),
            ],
            bannerAlign: context.knobs.object.dropdown(
              label: 'Align',
              options: BannerAlign.values,
              labelBuilder: (value) => value.name,
            ),
            bannerResponsive: context.knobs.object.dropdown(
              label: 'Responsive',
              options: BannerResponsive.values,
              labelBuilder: (value) => value.name,
            ),
            size: context.knobs.object.dropdown(
              label: 'size',
              options: BannerSize.values,
              labelBuilder: (value) => value.name,
            ),
          ),
          AppBanner(
            title: 'Title',
            subtitle: 'Description',
            onClosed: () {},
            type: BannerType.warning,
            style: style,
            actions: [
              AppBannerAction(title: 'Cancel', onPressed: () {}),
              AppBannerAction(title: 'Confirm', onPressed: () {}),
            ],
            bannerAlign: context.knobs.object.dropdown(
              label: 'Align',
              options: BannerAlign.values,
              labelBuilder: (value) => value.name,
            ),
            bannerResponsive: context.knobs.object.dropdown(
              label: 'Responsive',
              options: BannerResponsive.values,
              labelBuilder: (value) => value.name,
            ),
            size: context.knobs.object.dropdown(
              label: 'size',
              options: BannerSize.values,
              labelBuilder: (value) => value.name,
            ),
          ),
          AppBanner(
            title: 'Title',
            subtitle: 'Description',
            onClosed: () {},
            type: BannerType.idea,
            style: style,
            actions: [
              AppBannerAction(title: 'Cancel', onPressed: () {}),
              AppBannerAction(title: 'Confirm', onPressed: () {}),
            ],
            bannerAlign: context.knobs.object.dropdown(
              label: 'Align',
              options: BannerAlign.values,
              labelBuilder: (value) => value.name,
            ),
            bannerResponsive: context.knobs.object.dropdown(
              label: 'Responsive',
              options: BannerResponsive.values,
              labelBuilder: (value) => value.name,
            ),
            size: context.knobs.object.dropdown(
              label: 'size',
              options: BannerSize.values,
              labelBuilder: (value) => value.name,
            ),
          ),
        ],
      ),
    ),
  );
}
