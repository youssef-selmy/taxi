import 'package:better_design_system/molecules/file_upload/file_upload.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/datasources/upload_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';

class UploadFieldSmall extends StatelessWidget {
  final String? title;
  final Fragment$Media? initialValue;
  final Function(Fragment$Media?)? onChanged;
  final String? Function(Fragment$Media?)? validator;
  final Function(Fragment$Media?)? onSaved;

  const UploadFieldSmall({
    super.key,
    this.title,
    required this.onChanged,
    this.initialValue,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return AppFileUpload(
      title: title,
      initialValue: initialValue,
      imageUrlGetter: (media) => media.address,
      onUpload: (path, bytes) async {
        return locator<UploadDatasource>().uploadImage(path, fileBytes: bytes);
      },
      onUploaded: (media) => onChanged?.call(media.data),
      validator: validator,
      onSaved: onSaved,
    );
    // return FormField<Fragment$Media>(
    //   onSaved: widget.onSaved,
    //   validator: widget.validator,
    //   initialValue: widget.initialValue,
    //   builder: (state) {
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         if (widget.title != null) ...[
    //           Text(widget.title!, style: context.textTheme.bodyMedium),
    //           const SizedBox(height: 8),
    //         ],
    //         Stack(
    //           clipBehavior: Clip.none,
    //           children: [
    //             Container(
    //               width: widget.width,
    //               height: widget.height,
    //               decoration: BoxDecoration(
    //                 color: widget.backgroundColor ?? context.colors.surface,
    //                 border: state.value == null
    //                     ? Border.all(color: context.colors.outline)
    //                     : null,
    //                 borderRadius: BorderRadius.circular(8),
    //                 image: state.value != null
    //                     ? DecorationImage(
    //                         image: CachedNetworkImageProvider(
    //                           state.value!.address,
    //                         ),
    //                         fit: BoxFit.cover,
    //                       )
    //                     : null,
    //               ),
    //               child: state.value == null
    //                   ? Center(
    //                       child: Icon(
    //                         BetterIcons.camera01Filled,
    //                         size: 32,
    //                         color: context.colors.onSurfaceVariant,
    //                       ),
    //                     )
    //                   : null,
    //             ),
    //             Positioned(
    //               bottom: 0,
    //               left: 2,
    //               right: 2,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   if (state.value != null) ...[
    //                     CupertinoButton(
    //                       padding: EdgeInsets.zero,
    //                       onPressed: () {
    //                         state.didChange(null);
    //                         widget.onChanged?.call(null);
    //                       },
    //                       minimumSize: Size(0, 0),
    //                       child: Container(
    //                         padding: const EdgeInsets.all(6),
    //                         decoration: BoxDecoration(
    //                           shape: BoxShape.circle,
    //                           color: context.colors.errorVariantLow,
    //                           border: Border.all(color: context.colors.surface),
    //                         ),
    //                         child: Icon(
    //                           BetterIcons.delete03Outline,
    //                           size: 16,
    //                           color: context.colors.error,
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(width: 16),
    //                   ],
    //                   CupertinoButton(
    //                     padding: EdgeInsets.zero,
    //                     onPressed: () async {
    //                       final result = await FilePicker.platform.pickFiles(
    //                         type: FileType.image,
    //                         allowMultiple: false,
    //                         withData: true,
    //                       );
    //                       if (result != null) {
    //                         final media = await locator<UploadDatasource>()
    //                             .uploadImage(
    //                               result.files.single.path!,
    //                               fileBytes: result.files.single.bytes,
    //                             );
    //                         state.didChange(media);
    //                         widget.onChanged?.call(media);
    //                       }
    //                     },
    //                     minimumSize: Size(0, 0),
    //                     child: Container(
    //                       padding: const EdgeInsets.all(6),
    //                       decoration: BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         color: context.colors.primaryVariantLow,
    //                         border: Border.all(color: context.colors.surface),
    //                       ),
    //                       child: Icon(
    //                         BetterIcons.cloudUploadOutline,
    //                         size: 16,
    //                         color: context.colors.primary,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             // add space to the bottom
    //             SizedBox(height: widget.height + 15),
    //           ],
    //         ),
    //         if (state.errorText != null) ...[
    //           const SizedBox(height: 8),
    //           Text(
    //             state.errorText!,
    //             style: context.textTheme.bodyMedium?.apply(
    //               color: context.colors.error,
    //             ),
    //           ),
    //         ],
    //       ],
    //     );
    //   },
    // );
  }
}
