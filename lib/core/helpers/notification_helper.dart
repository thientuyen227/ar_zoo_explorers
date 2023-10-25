import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationHelper {
  static showLoadingDialog() {
    Get.dialog(
      const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircularProgressIndicator()),
      ),
      name: 'loading_dialog',
    );
  }

  static closeLoadingDialog() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  static showSnackBar({String? title, String? message}) {
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();

    Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
    ));
  }

  static closeSnackBar() {
    Get.closeCurrentSnackbar();
  }
}
