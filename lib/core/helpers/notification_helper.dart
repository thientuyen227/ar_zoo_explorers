import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationHelper {
  static showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  static showSnackBar({String? title, String? message}) {
    Fluttertoast.showToast(msg: message.toString());
  }
}
