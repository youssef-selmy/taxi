part of 'extensions.dart';

extension ToastX on BuildContext {
  void showToast(
    String message, {
    String? description,
    SemanticColor type = SemanticColor.info,
    ToastStyle style = ToastStyle.outline,
    ToastSize size = ToastSize.large,
  }) {
    final messenger = ScaffoldMessenger.of(this);
    // final screenWidth = MediaQuery.sizeOf(this).width;
    // final screenHeight = MediaQuery.sizeOf(this).height;
    // final isDesktop = screenWidth > 768;

    // // Space for status bar + AppBar; tweak if you have no AppBar
    // final topOffset = MediaQuery.viewPaddingOf(messenger.context).top + 32 + MediaQuery.paddingOf(messenger.context).top;

    // // Account for software keyboard
    // final bottomInset = MediaQuery.viewInsetsOf(messenger.context).bottom;

    // messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        // behavior: SnackBarBehavior.floating,
        // margin: isDesktop
        //     ? EdgeInsets.only(
        //         top: topOffset,
        //         right: 16,
        //         left: screenWidth > 516 ? screenWidth - 516 : 16,
        //       )
        //     : EdgeInsets.only(
        //         left: 16,
        //         right: 16,
        //         bottom: screenHeight - topOffset - 64 - bottomInset,
        //       ),
        content: AppToast(
          title: message.length > 100
              ? '${message.substring(0, 100)}...'
              : message,
          subtitle: description,
          color: type,
          toastStyle: style,
        ),
      ),
    );
  }

  void showFailure(ApiResponse message) => showToast(
    message.errorMessage ?? strings.somethingWentWrong,
    type: SemanticColor.error,
    style: ToastStyle.outline,
  );

  void showSuccess(String? message) => showToast(
    message ?? strings.success,
    type: SemanticColor.success,
    style: ToastStyle.outline,
  );
}

extension ToastOverlayX on BuildContext {
  Object? showToastOverlay(
    AppToast toast, {
    AlignmentGeometry? alignment,
    ToastOptions? options,
    bool append = true,
  }) {
    final state = ToastScope.of(this);
    // if options specify alignment or alignment passed, override
    if (alignment != null) {
      // naive way: create copy of options with alignment; our ToastOptions currently holds alignment
      final merged = ToastOptions(
        duration: options?.duration,
        alignment: alignment as AlignmentGeometry?,
        actions: options?.actions,
      );
      return state.show(toast, options: merged, append: append);
    }
    return state.show(toast, options: options, append: append);
  }
}
