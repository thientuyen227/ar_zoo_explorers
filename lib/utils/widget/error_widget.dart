import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';
import 'button_widget.dart';
import 'spacer_widget.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    Key? key,
    required this.onRetry,
    this.message,
  }) : super(key: key);
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spacing20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(message ?? context.localizations.errorUnknown, textAlign: TextAlign.center),
            // const VSpacing(),
            // AppTextButton(
            //   onPressed: () => onRetry(),
            //   title: context.localizations.retryBtnTitle,
            // )
            Text(message ?? "", textAlign: TextAlign.center),
            const VSpacing(),
            AppTextButton(
              onPressed: () => onRetry(),
              title: "",
            )
          ],
        ),
      ),
    );
  }
}
