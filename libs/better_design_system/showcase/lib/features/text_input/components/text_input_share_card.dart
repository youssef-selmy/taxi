import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TextInputShareCard extends StatelessWidget {
  const TextInputShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.surfaceVariant,
              ),
              child: Center(
                child: Assets.images.iconsTwotone.link04.svg(
                  width: 40,
                  height: 40,
                  colorFilter: ColorFilter.mode(
                    context.colors.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Share this with Your\nSocial Community',
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppOutlinedButton(
                    size: ButtonSize.extraLarge,
                    color: SemanticColor.neutral,
                    onPressed: () {},
                    child: Assets.images.brands.facebook.image(
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppOutlinedButton(
                    size: ButtonSize.extraLarge,
                    color: SemanticColor.neutral,
                    onPressed: () {},
                    child: Assets.images.brands.telegram.image(
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppOutlinedButton(
                    size: ButtonSize.extraLarge,
                    color: SemanticColor.neutral,
                    onPressed: () {},
                    child: Assets.images.brands.whatsapp.image(
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: context.colors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.colors.outline),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            BetterIcons.link04Outline,
                            size: 20,
                            color: context.colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'https://bettersuite.com/UIKit',
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: context.colors.outline,
                  ),
                  _CopyButton(onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _CopyButton({required this.onPressed});

  @override
  State<_CopyButton> createState() => __CopyButtonState();
}

class __CopyButtonState extends State<_CopyButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  int get _buttonState {
    if (_isPressed) return 2;
    if (_isHovered) return 1;
    return 0;
  }

  Color _getBackgroundColor(BuildContext context) => switch (_buttonState) {
    2 => context.colors.surfaceVariant,
    1 => context.colors.surfaceVariantLow,
    _ => context.colors.surface,
  };

  Color _getIconColor(BuildContext context) => context.colors.onSurface;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      onShowHoverHighlight: (v) => setState(() => _isHovered = v),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: Container(
          width: 52,
          height: double.infinity,
          decoration: BoxDecoration(
            color: _getBackgroundColor(context),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Icon(
              BetterIcons.copyOutline,
              size: 20,
              color: _getIconColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
