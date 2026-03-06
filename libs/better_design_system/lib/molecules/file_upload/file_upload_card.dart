import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/molecules/file_upload/upload_card_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:cross_file/cross_file.dart';

export 'upload_card_style.dart';

typedef BetterFileUploadCard = AppFileUploadCard;

class AppFileUploadCard extends StatefulWidget {
  final String primaryMessage;
  final String secondaryMessage;
  final String buttonText;
  final Future<void> Function(List<PlatformFile> files) onFilesSelected;
  final List<String>? allowedExtensions;
  final int? maxFileSizeBytes;
  final bool allowMultiple;
  final bool isDisabled;
  final bool isDashed;
  final UploadCardStyle style;

  const AppFileUploadCard({
    super.key,
    required this.primaryMessage,
    required this.secondaryMessage,
    required this.buttonText,
    required this.onFilesSelected,
    this.allowedExtensions,
    this.maxFileSizeBytes,
    this.allowMultiple = false,
    this.isDisabled = false,
    this.isDashed = false,
    this.style = UploadCardStyle.outlined,
  });

  @override
  State<AppFileUploadCard> createState() => _AppFileUploadCardState();
}

class _AppFileUploadCardState extends State<AppFileUploadCard> {
  bool _isDragOver = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800, minWidth: 0),
      child: SizedBox(
        width: double.infinity,
        height: 226,
        child: DropTarget(
          onDragDone: (detail) {
            if (!widget.isDisabled) {
              _handleDroppedFiles(detail.files);
            }
          },
          onDragEntered: (detail) {
            if (!widget.isDisabled) {
              setState(() => _isDragOver = true);
            }
          },
          onDragExited: (detail) {
            setState(() {
              _isDragOver = false;
              _isHovered = false;
            });
          },
          child: FocusableActionDetector(
            onShowHoverHighlight: (isHovered) {
              if (!_isDragOver) {
                setState(() => _isHovered = isHovered);
              }
            },
            child: widget.isDashed
                ? CustomPaint(
                    painter: _DashedBorderPainter(
                      color: _getBorderColor(context),
                      borderRadius: 10,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: _getBackgroundColor(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _buildContent(context, _isHovered || _isDragOver),
                    ),
                  )
                : AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: _getBackgroundColor(context),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _getBorderColor(context),
                        width: 1.0,
                      ),
                    ),
                    child: _buildContent(context, _isHovered || _isDragOver),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isHovered) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            BetterIcons.cloudUploadOutline,
            size: 40,
            color: widget.isDisabled
                ? context.colors.onSurfaceDisabled
                : widget.style == UploadCardStyle.filled
                ? context.colors.onSurfaceVariant
                : context.colors.primary,
          ),

          const SizedBox(height: 20),

          Text(
            widget.primaryMessage,
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: widget.isDisabled
                  ? context.colors.onSurfaceDisabled
                  : context.colors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            widget.secondaryMessage,
            style: context.textTheme.bodySmall?.copyWith(
              color: widget.isDisabled
                  ? context.colors.onSurfaceDisabled
                  : context.colors.onSurfaceVariantLow,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          AppOutlinedButton(
            text: widget.buttonText,
            onPressed: widget.isDisabled ? null : _pickFiles,
            isDisabled: widget.isDisabled,
            color: SemanticColor.primary,
            size: ButtonSize.medium,
            alignment: MainAxisAlignment.center,
            suffixIcon: BetterIcons.arrowUp03Outline,
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.isDisabled) {
      return context.colors.surfaceMuted;
    }

    if (_isDragOver) {
      return context.colors.primaryContainer.withAlpha((0.08 * 255).round());
    }

    if (widget.style == UploadCardStyle.filled) {
      if (_isHovered) {
        return context.colors.surfaceVariant;
      }
      return context.colors.surfaceVariantLow;
    } else {
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

    if (_isDragOver) {
      return context.colors.primary;
    }

    return context.colors.outlineVariant;
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
        allowMultiple: widget.allowMultiple,
      );

      if (result != null && result.files.isNotEmpty) {
        final validFiles = _validateFiles(result.files);
        if (validFiles.isNotEmpty) {
          await widget.onFilesSelected(validFiles);
        }
      }
    } catch (e) {
      // Handle errors silently
    }
  }

  void _handleDroppedFiles(List<XFile> files) async {
    setState(() => _isDragOver = false);

    if (files.isEmpty) return;

    try {
      final platformFiles = <PlatformFile>[];

      for (final file in files) {
        final bytes = await file.readAsBytes();
        final platformFile = PlatformFile(
          name: file.name,
          size: bytes.length,
          bytes: bytes,
          path: file.path,
        );
        platformFiles.add(platformFile);
      }

      final validFiles = _validateFiles(platformFiles);
      if (validFiles.isNotEmpty) {
        await widget.onFilesSelected(validFiles);
      } else {
        _showErrorSnackBar('No valid files found');
      }
    } catch (e) {
      _showErrorSnackBar('Error processing dropped files');
    }
  }

  List<PlatformFile> _validateFiles(List<PlatformFile> files) {
    return files.where((file) {
      if (widget.maxFileSizeBytes != null &&
          file.size > widget.maxFileSizeBytes!) {
        _showErrorSnackBar('File "${file.name}" exceeds maximum size limit');
        return false;
      }

      if (widget.allowedExtensions != null) {
        final extension = file.extension?.toLowerCase();
        if (extension == null ||
            !widget.allowedExtensions!.contains(extension)) {
          _showErrorSnackBar('File "${file.name}" has unsupported format');
          return false;
        }
      }

      return true;
    }).toList();
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: context.colors.error),
      );
    }
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double strokeWidth = 2.0;
  final double dashWidth = 5.0;
  final double dashSpace = 5.0;

  _DashedBorderPainter({required this.color, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    final radius = Radius.circular(borderRadius);
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        radius,
      ),
    );

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics(forceClosed: false);
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
