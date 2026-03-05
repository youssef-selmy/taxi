import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_icons/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class FullscreenImageViewerDialog extends StatefulWidget {
  final String imageUrl;
  final String? title;

  const FullscreenImageViewerDialog({
    super.key,
    required this.imageUrl,
    this.title,
  });

  static Future<void> show(
    BuildContext context, {
    required String imageUrl,
    String? title,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) =>
          FullscreenImageViewerDialog(imageUrl: imageUrl, title: title),
    );
  }

  @override
  State<FullscreenImageViewerDialog> createState() =>
      _FullscreenImageViewerDialogState();
}

class _FullscreenImageViewerDialogState
    extends State<FullscreenImageViewerDialog> {
  final TransformationController _transformationController =
      TransformationController();
  double _currentScale = 1.0;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
    setState(() {
      _currentScale = 1.0;
    });
  }

  void _zoomIn() {
    final newScale = (_currentScale * 1.5).clamp(1.0, 5.0);
    _transformationController.value = Matrix4.diagonal3Values(
      newScale,
      newScale,
      1,
    );
    setState(() {
      _currentScale = newScale;
    });
  }

  void _zoomOut() {
    final newScale = (_currentScale / 1.5).clamp(1.0, 5.0);
    _transformationController.value = Matrix4.diagonal3Values(
      newScale,
      newScale,
      1,
    );
    setState(() {
      _currentScale = newScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.of(context).pop(),
      },
      child: Focus(
        autofocus: true,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(color: Colors.transparent),
              ),
              Center(
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: 1.0,
                  maxScale: 5.0,
                  onInteractionEnd: (details) {
                    setState(() {
                      _currentScale = _transformationController.value
                          .getMaxScaleOnAxis();
                    });
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: context.colors.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            context.tr.error,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.title != null)
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.title!,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 16,
                right: 16,
                child: AppIconButton(
                  style: IconButtonStyle.outline,
                  icon: BetterIcons.cancel01Outline,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoButton(
                          minimumSize: Size(0, 0),
                          padding: EdgeInsets.zero,
                          onPressed: _currentScale > 1.0 ? _zoomOut : null,
                          child: Icon(
                            BetterIcons.searchMinusFilled,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '${(_currentScale * 100).toInt()}%',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CupertinoButton(
                          minimumSize: Size(0, 0),
                          padding: EdgeInsets.zero,
                          onPressed: _currentScale < 5.0 ? _zoomIn : null,
                          child: Icon(
                            BetterIcons.searchAddFilled,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        CupertinoButton(
                          minimumSize: Size(0, 0),
                          padding: EdgeInsets.zero,
                          onPressed: _currentScale != 1.0 ? _resetZoom : null,
                          child: Icon(
                            BetterIcons.arrowReloadHorizontalOutline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
