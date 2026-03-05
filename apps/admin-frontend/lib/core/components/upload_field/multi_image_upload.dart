import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import 'package:admin_frontend/core/datasources/upload_datasource.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_icons/better_icons.dart';

class MultiImageUpload extends StatelessWidget {
  final List<Fragment$Media> images;
  final int? maxImages;
  final Function(List<Fragment$Media>) onChanged;

  const MultiImageUpload({
    super.key,
    required this.images,
    this.maxImages,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: [
        for (final image in images)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: MultiUploadImage(
              image: image,
              onDelete: () {
                final index = images.indexOf(image);
                onChanged(images..removeAt(index));
              },
            ),
          ),
        if (maxImages == null || images.length < maxImages!)
          MultiUploadUploadButton(
            onUplaoded: (media) {
              onChanged([...images, media]);
            },
          ),
      ],
    );
  }
}

class MultiUploadUploadButton extends StatelessWidget {
  final Function(Fragment$Media) onUplaoded;

  const MultiUploadUploadButton({super.key, required this.onUplaoded});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
          withData: true,
        );
        if (result != null) {
          final media = await locator<UploadDatasource>().uploadImage(
            result.files.single.path!,
            fileBytes: result.files.single.bytes,
          );
          onUplaoded(media.data!);
        }
      },
      minimumSize: Size(0, 0),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                BetterIcons.cloudUploadOutline,
                color: context.colors.primary,
                size: 40,
              ),
              const SizedBox(height: 8),
              Text(
                context.tr.uploadImage,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiUploadImage extends StatefulWidget {
  final Fragment$Media image;
  final Function() onDelete;

  const MultiUploadImage({
    super.key,
    required this.image,
    required this.onDelete,
  });

  @override
  State<MultiUploadImage> createState() => _MultiUploadImageState();
}

class _MultiUploadImageState extends State<MultiUploadImage> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: widget.image.widget(width: 140, height: 140),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: isHovered ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: Colors.white.withValues(alpha: 0.3),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      BetterIcons.delete03Outline,
                      color: context.colors.error,
                    ),
                    onPressed: widget.onDelete,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
