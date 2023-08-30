import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import '../../app/theme/dimens.dart';
import '../../utils/extension/context_ext.dart';
import '../../utils/widget/spacer_widget.dart';
import 'button_widget.dart';

class AppDialogPage extends StatelessWidget {
  final String? title;
  final String message;
  final String? buttonTitle;

  const AppDialogPage({
    Key? key,
    this.title,
    required this.message,
    this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myTheme = context.myTheme;

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.spacing40),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.spacing15),
              decoration: BoxDecoration(
                  color: context.myTheme.colorScheme.cardColor,
                  borderRadius: BorderRadius.circular(AppDimens.radius25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null) ...{
                    Text(
                      title!,
                      style: myTheme.textThemeT1.button.copyWith(color: myTheme.colorScheme.textColor),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    )
                  },
                  const VSpacing(spacing: AppDimens.spacing20),
                  Text(
                    message,
                    style: myTheme.textThemeT3.light.copyWith(color: myTheme.colorScheme.textColor),
                    textAlign: TextAlign.center,
                    maxLines: 8,
                  ),
                  const VSpacing(spacing: AppDimens.spacing30),
                  AppPrimaryButton(
                    titleStyle: context.myTheme.textThemeT1.button.copyWith(
                      color: AppColor.white,
                    ),
                    buttonColor: myTheme.colorScheme.btnColor,
                    onPressed: () => context.router.pop(),
                    title: buttonTitle ?? 'Close',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? buttonTitle;

  const AppDialog({
    Key? key,
    this.title,
    required this.message,
    this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myTheme = context.myTheme;

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.spacing40),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.spacing15),
              decoration: BoxDecoration(
                  color: context.myTheme.colorScheme.dialogColor,
                  borderRadius: BorderRadius.circular(AppDimens.buttonRadius)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null) ...{
                    Text(
                      title!,
                      style: myTheme.textThemeT1.bigTitle
                          .copyWith(color: myTheme.colorScheme.textColor, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    )
                  },
                  if (message.isNotEmpty) ...{
                    const VSpacing(spacing: AppDimens.spacing20),
                    Text(
                      message,
                      style: myTheme.textThemeT3.light.copyWith(color: myTheme.colorScheme.textColor),
                      textAlign: TextAlign.center,
                      maxLines: 8,
                    ),
                  },
                  const VSpacing(spacing: AppDimens.spacing30),
                  FractionallySizedBox(
                    widthFactor: 235 / 300,
                    child: AspectRatio(
                      aspectRatio: 235 / 48,
                      child: AppTextButton(
                          onPressed: () {
                            context.router.popForced();
                          },
                          title: buttonTitle ?? 'Close',
                          style: context.myTheme.textThemeT1.button.copyWith(fontWeight: FontWeight.normal)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppOptionalDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonTitle;
  final VoidCallback onPressedBtn;
  final String? altButtonTitle;
  final VoidCallback onPressedAltBtn;
  final Widget? decorationWidget;
  final bool barrierDismissable;

  const AppOptionalDialog({
    Key? key,
    this.title,
    this.message,
    this.buttonTitle,
    this.altButtonTitle,
    this.decorationWidget,
    this.barrierDismissable = false,
    required this.onPressedAltBtn,
    required this.onPressedBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myTheme = context.myTheme;

    return GestureDetector(
      onTap: () {
        if (barrierDismissable) {
          context.router.popForced();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimens.spacing40),
              child: Container(
                padding: const EdgeInsets.all(AppDimens.spacing15),
                decoration: BoxDecoration(
                    color: context.myTheme.colorScheme.cardColor,
                    borderRadius: BorderRadius.circular(AppDimens.radius25)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (decorationWidget != null) ...{
                      decorationWidget!,
                      const VSpacing(spacing: AppDimens.spacing20),
                    },
                    if (title != null) ...{
                      const VSpacing(spacing: AppDimens.spacing12),
                      Text(
                        title!,
                        style: myTheme.textThemeT1.bigTitle,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      const VSpacing(spacing: AppDimens.spacing20),
                    },
                    if (message != null) ...{
                      Text(
                        message!,
                        style: myTheme.textThemeT3.light,
                        textAlign: TextAlign.center,
                        maxLines: 8,
                      ),
                      const VSpacing(spacing: AppDimens.spacing20),
                    },
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          AppPrimaryButton(
                            onPressed: () {
                              onPressedBtn();
                              context.router.popForced();
                            },
                            title: buttonTitle ?? 'Ok',
                          ),
                        ]),
                        const TableRow(children: [
                          VSpacing(),
                        ]),
                        TableRow(children: [
                          AppTextButton(
                            style: context.myTheme.textThemeT1.button,
                            onPressed: () {
                              onPressedAltBtn();
                              context.router.popForced();
                            },
                            title: altButtonTitle ?? 'Cancel',
                          )
                        ]),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
