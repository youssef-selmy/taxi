import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar.dart';
import 'package:better_design_system/molecules/file_upload/upload_card_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'upload_card_style.dart';

typedef BetterFileUploadProgressCard = AppFileUploadProgressCard;

class AppFileUploadProgressCard extends StatefulWidget {
  final double progress;
  final String cancelButtonText;
  final VoidCallback? onCancel;
  final bool isDisabled;
  final UploadCardStyle style;
  final CircularProgressBarStatus status;

  const AppFileUploadProgressCard({
    super.key,
    required this.progress,
    required this.cancelButtonText,
    this.onCancel,
    this.isDisabled = false,
    this.style = UploadCardStyle.outlined,
    this.status = CircularProgressBarStatus.uploading,
  }) : assert(
         progress >= 0.0 && progress <= 1.0,
         'Progress must be between 0 and 1',
       );

  @override
  State<AppFileUploadProgressCard> createState() =>
      _AppFileUploadProgressCardState();
}

class _AppFileUploadProgressCardState extends State<AppFileUploadProgressCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800, minWidth: 0),
      child: SizedBox(
        width: double.infinity,
        height: 226,
        child: FocusableActionDetector(
          onShowHoverHighlight: (isHovered) {
            setState(() => _isHovered = isHovered);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _getBorderColor(context), width: 1.0),
            ),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Progress Bar
          AppCircularProgressBar(
            size: CircularProgressBarSize.size32px,
            status: widget.status,
            progress: widget.progress,
            showProgressNumber: false,
            color: SemanticColor.primary,
          ),

          const SizedBox(height: 35),

          // Progress Message
          Text(
            'Uploading... ${(widget.progress * 100).toInt()}% completed',
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: widget.isDisabled
                  ? context.colors.onSurfaceDisabled
                  : context.colors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 35),

          // Cancel Button
          AppTextButton(
            text: widget.cancelButtonText,
            onPressed: widget.isDisabled ? null : widget.onCancel,
            isDisabled: widget.isDisabled,
            color: SemanticColor.error,
            size: ButtonSize.medium,
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.isDisabled) {
      return context.colors.surfaceMuted;
    }

    if (widget.style == UploadCardStyle.filled) {
      if (_isHovered) {
        return context.colors.surfaceVariant;
      }
      return context.colors.surfaceVariantLow;
    } else {
      // UploadCardStyle.outlined
      if (_isHovered) {
        return context.colors.surfaceVariantLow;
      }
      return context.colors.surface;
    }
  }

  Color _getBorderColor(BuildContext context) {
    if (widget.isDisabled) {
      return context.colors.outlineDisabled;
    }

    return context.colors.outlineVariant;
  }
}
