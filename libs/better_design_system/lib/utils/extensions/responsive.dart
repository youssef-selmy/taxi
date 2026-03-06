part of 'extensions.dart';

extension BuildcontextResponsiveX on BuildContext {
  bool get isDesktop => responsive(false, lg: true);

  bool get isMobile => responsive(true, lg: false);

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  double get bottomPadding => MediaQuery.viewPaddingOf(this).bottom;
  double get topPadding => MediaQuery.viewPaddingOf(this).top;

  T responsive<T>(T defaultVal, {T? sm, T? md, T? lg, T? xl}) {
    final wd = width;
    return wd >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultVal)
        : wd >= 1024
        ? (lg ?? md ?? sm ?? defaultVal)
        : wd >= 768
        ? (md ?? sm ?? defaultVal)
        : wd >= 640
        ? (sm ?? defaultVal)
        : defaultVal;
  }
}
