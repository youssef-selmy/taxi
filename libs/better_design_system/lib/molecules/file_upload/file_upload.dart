import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/soft_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

enum UploadFieldStyle { compact, vertical, horizontal }

typedef BetterFileUpload = AppFileUpload;

class AppFileUpload<T> extends FormField<T> {
  final String? title;
  final String? subtitle;

  final String? Function(T) imageUrlGetter;

  final UploadFieldStyle style;

  /// This function has the local path of the file as parameter and returns the uploaded file URL
  /// or null if the upload failed.
  final Future<ApiResponse<T>> Function(String, Uint8List?) onUpload;

  final void Function(ApiResponse<T>)? onUploaded;

  /// This function is called when the delete button is pressed.
  /// It should handle the deletion of the file and return a boolean indicating success.
  final bool Function(T)? onDelete;

  AppFileUpload({
    super.key,
    this.title,
    this.subtitle,
    required this.imageUrlGetter,
    this.style = UploadFieldStyle.compact,
    required this.onUpload,
    this.onUploaded,
    this.onDelete,
    super.validator,
    super.initialValue,
    super.onSaved,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
    super.enabled,
  }) : super(
         builder: (FormFieldState<T> state) {
           return _AppFileUploadContent<T>(
             title: title,
             subtitle: subtitle,
             image: state.value != null
                 ? ApiResponse.loaded(state.value as T)
                 : ApiResponse.initial(),
             imageUrlGetter: imageUrlGetter,
             style: style,
             onUpload: onUpload,
             onUploaded: onUploaded,
             onDelete: onDelete,
             state: state,
           );
         },
       );
}

class _AppFileUploadContent<T> extends StatefulWidget {
  static const double _spacingSmall = 8.0;
  static const double _spacingMedium = 16.0;
  static const double _spacingLarge = 20.0;
  static const double _spacingXLarge = 24.0;
  static const AvatarSize _avatarDetailedSize = AvatarSize.size72px;
  static const AvatarSize _avatarOnlySize = AvatarSize.size96px;
  static const ButtonSize _actionButtonSize = ButtonSize.large;

  final String? title;
  final String? subtitle;
  final ApiResponse<T> image;
  final String? Function(T) imageUrlGetter;
  final UploadFieldStyle style;
  final Future<ApiResponse<T>> Function(String, Uint8List?) onUpload;
  final void Function(ApiResponse<T>)? onUploaded;
  final bool Function(T)? onDelete;
  final FormFieldState<T> state;

  const _AppFileUploadContent({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.imageUrlGetter,
    required this.style,
    required this.onUpload,
    required this.onUploaded,
    required this.onDelete,
    required this.state,
  });

  @override
  State<_AppFileUploadContent<T>> createState() =>
      _AppFileUploadContentState<T>();
}

class _AppFileUploadContentState<T> extends State<_AppFileUploadContent<T>> {
  late ApiResponse<T> _uploadState;

  @override
  void initState() {
    super.initState();
    _uploadState = widget.image;
  }

  @override
  void didUpdateWidget(covariant _AppFileUploadContent<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update upload state when external image changes (e.g., form reset)
    if (oldWidget.image != widget.image) {
      _uploadState = widget.image;
    }
  }

  String? get _imageUrl {
    return _uploadState.data != null
        ? widget.imageUrlGetter(_uploadState.data as T)
        : null;
  }

  /// Builds the avatar with state-aware display (loading, error, loaded)
  Widget _buildAvatar(BuildContext context, AvatarSize size) {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: switch (_uploadState) {
        ApiResponseInitial() || ApiResponseLoaded() => AppAvatar(
          key: ValueKey(_imageUrl),
          imageUrl: _imageUrl,
          shape: AvatarShape.circle,
          size: size,
        ),
        ApiResponseLoading() => Container(
          key: const ValueKey('loading'),
          width: size.value,
          height: size.value,
          decoration: BoxDecoration(
            color: context.colors.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: context.colors.onSurface,
              strokeWidth: 3,
            ),
          ),
        ),
        ApiResponseError() => Stack(
          key: ValueKey(_imageUrl),
          children: [
            Container(
              width: size.value,
              height: size.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.colors.error, width: 2),
              ),
              child: ClipOval(
                child: AppAvatar(
                  imageUrl: _imageUrl,
                  shape: AvatarShape.circle,
                  size: size,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.colors.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colors.surface, width: 2),
                ),
                child: Icon(
                  BetterIcons.alertCircleOutline,
                  size: 16,
                  color: context.colors.onError,
                ),
              ),
            ),
          ],
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final shouldCenterErrors =
        widget.style == UploadFieldStyle.compact ||
        widget.style == UploadFieldStyle.vertical;

    return Column(
      crossAxisAlignment: shouldCenterErrors
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildUploadWidget(context),
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.state.errorText!,
              style: TextStyle(color: context.colors.error, fontSize: 12),
              textAlign: shouldCenterErrors
                  ? TextAlign.center
                  : TextAlign.start,
            ),
          ),
        if (_uploadState is ApiResponseError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              (_uploadState as ApiResponseError).message,
              style: TextStyle(color: context.colors.error, fontSize: 12),
              textAlign: shouldCenterErrors
                  ? TextAlign.center
                  : TextAlign.start,
            ),
          ),
      ],
    );
  }

  Widget _buildUploadWidget(BuildContext context) => switch (widget.style) {
    UploadFieldStyle.horizontal => _buildHorizontalLayout(context),
    UploadFieldStyle.vertical => _buildVerticalLayout(context),
    UploadFieldStyle.compact => _buildAvatarOnly(context),
  };

  // Builds the avatar-only view with overlay button
  Widget _buildAvatarOnly(BuildContext context) {
    const AvatarSize currentAvatarSize = _AppFileUploadContent._avatarOnlySize;
    const IconData overlayIconData = BetterIcons.add01Outline;
    final Color iconFgColor = context.colors.onSurface;
    final Color iconBgColor = context.colors.surfaceVariant;

    return SizedBox(
      width: currentAvatarSize.value,
      height: currentAvatarSize.value,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          _buildAvatar(context, currentAvatarSize),
          _buildSecondaryButtonOverlay(
            context,
            iconBgColor,
            iconFgColor,
            overlayIconData,
          ),
        ],
      ),
    );
  }

  // Builds the detailed vertical layout
  Widget _buildVerticalLayout(BuildContext context) {
    const AvatarSize currentAvatarSize =
        _AppFileUploadContent._avatarDetailedSize;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        _buildAvatar(context, currentAvatarSize),
        if (widget.subtitle != null)
          Text(
            widget.subtitle!,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        _buildActions(context),
      ],
    );
  }

  // Builds the detailed horizontal layout (top-aligned)
  Widget _buildHorizontalLayout(BuildContext context) {
    const AvatarSize currentAvatarSize =
        _AppFileUploadContent._avatarDetailedSize;
    final hasText = widget.title != null || widget.subtitle != null;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: hasText
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      spacing: _AppFileUploadContent._spacingXLarge,
      children: [
        _buildAvatar(context, currentAvatarSize),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: hasText
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            _buildTextSection(context, CrossAxisAlignment.start),
            if (hasText)
              const SizedBox(height: _AppFileUploadContent._spacingLarge),
            _buildActions(context),
          ],
        ),
      ],
    );
  }

  // Builds the text section (for detailed mode, handles nulls)
  Widget _buildTextSection(
    BuildContext context,
    CrossAxisAlignment crossAxisAlignment,
  ) {
    if (widget.title == null && widget.subtitle == null) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      spacing: _AppFileUploadContent._spacingSmall,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: context.textTheme.titleMedium,
            textAlign: crossAxisAlignment == CrossAxisAlignment.center
                ? TextAlign.center
                : TextAlign.start,
          ),
        if (widget.subtitle != null)
          Text(
            widget.subtitle!,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            textAlign: crossAxisAlignment == CrossAxisAlignment.center
                ? TextAlign.center
                : TextAlign.start,
          ),
      ],
    );
  }

  // Builds the action buttons (for detailed mode) using switch expression
  Widget _buildActions(BuildContext context) {
    return switch (_uploadState) {
      ApiResponseInitial() => AppSoftButton(
        text: context.strings.uploadImage,
        onPressed: _uploadFile,
        size: _AppFileUploadContent._actionButtonSize,
      ),
      ApiResponseLoading() => AppSoftButton(
        text: context.strings.uploadImage,
        onPressed: null,
        size: _AppFileUploadContent._actionButtonSize,
        isDisabled: true,
      ),
      ApiResponseLoaded() || ApiResponseError() => SizedBox(
        width: 216,
        child: Row(
          spacing: _AppFileUploadContent._spacingMedium,
          children: [
            Expanded(
              child: AppOutlinedButton(
                text: context.strings.change,
                onPressed: _uploadState.isLoading ? null : _uploadFile,
                size: _AppFileUploadContent._actionButtonSize,
                isDisabled: _uploadState.isLoading,
              ),
            ),
            if (widget.onDelete != null)
              Expanded(
                child: AppSoftButton(
                  text: context.strings.delete,
                  onPressed: _uploadState.isLoading
                      ? null
                      : () {
                          if (widget.onDelete != null) {
                            final result = widget.onDelete!(
                              _uploadState.data as T,
                            );
                            if (result) {
                              widget.state.didChange(null);
                              setState(() {
                                _uploadState = ApiResponse<T>.initial();
                              });
                              if (widget.onUploaded != null) {
                                widget.onUploaded!(ApiResponse<T>.initial());
                              }
                            }
                          }
                        },
                  isDisabled: _uploadState.isLoading || widget.onDelete == null,
                  size: _AppFileUploadContent._actionButtonSize,
                  color: SemanticColor.error,
                ),
              ),
          ],
        ),
      ),
    };
  }

  /// Builds the positioned overlay button ("secondary button") for avatarOnly mode.
  Widget _buildSecondaryButtonOverlay(
    BuildContext context,
    Color iconBgColor,
    Color iconFgColor,
    IconData overlayIconData,
  ) {
    // Hide overlay button during loading
    if (_uploadState.isLoading) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 0,
      right: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _uploadFile,
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.colors.transparent,
        splashColor: context.colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
            border: Border.all(color: context.colors.surface, width: 2),
          ),
          child: Icon(overlayIconData, size: 18, color: iconFgColor),
        ),
      ),
    );
  }

  Future<void> _uploadFile() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
      compressionQuality: 95,
    );
    if (file != null) {
      // Set loading state
      setState(() {
        _uploadState = ApiResponse<T>.loading();
      });

      // Call the upload function
      final uploadResult = await widget.onUpload(
        file.files.single.path!,
        file.files.single.bytes,
      );

      // Update state with result
      setState(() {
        _uploadState = uploadResult;
      });

      // Update form field value only on success
      if (uploadResult.isLoaded) {
        widget.state.didChange(uploadResult.data);
      }

      // Notify parent
      if (widget.onUploaded != null) {
        widget.onUploaded!(uploadResult);
      }
    }
  }
}
