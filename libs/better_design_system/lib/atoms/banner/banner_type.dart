import 'package:better_design_system/colors/semantic_color.dart';

enum BannerType {
  success,
  error,
  warning,
  info,
  idea,
  none;

  SemanticColor get color => switch (this) {
    BannerType.success => SemanticColor.success,
    BannerType.error => SemanticColor.error,
    BannerType.warning => SemanticColor.warning,
    BannerType.info => SemanticColor.info,
    BannerType.idea => SemanticColor.primary,
    BannerType.none => SemanticColor.neutral,
  };
}
