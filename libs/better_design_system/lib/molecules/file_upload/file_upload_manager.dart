import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar_status.dart';
import 'package:better_design_system/molecules/file_upload/file_upload_card.dart';
import 'package:better_design_system/molecules/file_upload/file_upload_progress_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

export 'upload_card_style.dart';

typedef BetterFileUploadManager = AppFileUploadManager;

class AppFileUploadManager extends StatefulWidget {
  final String primaryMessage;
  final String secondaryMessage;
  final String buttonText;
  final String cancelButtonText;
  final Stream<double> Function(List<PlatformFile> files) onUpload;
  final VoidCallback? onCancel;
  final void Function(List<PlatformFile> files)? onCompleted;
  final void Function(String error)? onError;
  final List<String>? allowedExtensions;
  final int? maxFileSizeBytes;
  final bool allowMultiple;
  final bool isDisabled;
  final UploadCardStyle style;

  const AppFileUploadManager({
    super.key,
    required this.primaryMessage,
    required this.secondaryMessage,
    required this.buttonText,
    required this.cancelButtonText,
    required this.onUpload,
    this.onCancel,
    this.onCompleted,
    this.onError,
    this.allowedExtensions,
    this.maxFileSizeBytes,
    this.allowMultiple = false,
    this.isDisabled = false,
    this.style = UploadCardStyle.outlined,
  });

  @override
  State<AppFileUploadManager> createState() => _AppFileUploadManagerState();
}

class _AppFileUploadManagerState extends State<AppFileUploadManager> {
  CircularProgressBarStatus _uploadState = CircularProgressBarStatus.pending;
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    switch (_uploadState) {
      case CircularProgressBarStatus.pending:
        return AppFileUploadCard(
          primaryMessage: widget.primaryMessage,
          secondaryMessage: widget.secondaryMessage,
          buttonText: widget.buttonText,
          onFilesSelected: _handleFilesSelected,
          allowedExtensions: widget.allowedExtensions,
          maxFileSizeBytes: widget.maxFileSizeBytes,
          allowMultiple: widget.allowMultiple,
          isDisabled: widget.isDisabled,
          style: widget.style,
        );

      case CircularProgressBarStatus.uploading:
        return AppFileUploadProgressCard(
          progress: _progress,
          cancelButtonText: widget.cancelButtonText,
          onCancel: _handleCancel,
          isDisabled: widget.isDisabled,
          style: widget.style,
          status: CircularProgressBarStatus.uploading,
        );

      case CircularProgressBarStatus.success:
        return AppFileUploadProgressCard(
          progress: 1.0,
          cancelButtonText: 'Done',
          onCancel: _resetToUpload,
          isDisabled: widget.isDisabled,
          style: widget.style,
          status: CircularProgressBarStatus.success,
        );

      case CircularProgressBarStatus.error:
        return AppFileUploadProgressCard(
          progress: _progress,
          cancelButtonText: 'Try Again',
          onCancel: _resetToUpload,
          isDisabled: widget.isDisabled,
          style: widget.style,
          status: CircularProgressBarStatus.error,
        );
    }
  }

  Future<void> _handleFilesSelected(List<PlatformFile> files) async {
    setState(() {
      _uploadState = CircularProgressBarStatus.uploading;
      _progress = 0.0;
    });

    try {
      final progressStream = widget.onUpload(files);

      await for (final progress in progressStream) {
        if (_uploadState == CircularProgressBarStatus.uploading) {
          setState(() {
            _progress = progress.clamp(0.0, 1.0);
          });

          if (progress >= 1.0) {
            setState(() {
              _uploadState = CircularProgressBarStatus.success;
            });
            widget.onCompleted?.call(files);
            break;
          }
        } else {
          break;
        }
      }
    } catch (error) {
      setState(() {
        _uploadState = CircularProgressBarStatus.error;
      });
      widget.onError?.call(error.toString());
    }
  }

  void _handleCancel() {
    setState(() {
      _uploadState = CircularProgressBarStatus.pending;
      _progress = 0.0;
    });
    widget.onCancel?.call();
  }

  void _resetToUpload() {
    setState(() {
      _uploadState = CircularProgressBarStatus.pending;
      _progress = 0.0;
    });
  }
}
