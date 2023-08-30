import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';
import '../../utils/extension/context_ext.dart';
import 'spacer_widget.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    Key? key,
    this.color,
    this.dimension,
    this.withScafold = false,
  }) : super(key: key);

  final Color? color;
  final double? dimension;
  final bool withScafold;

  @override
  Widget build(BuildContext context) {
    if (withScafold) {
      return Scaffold(body: _buildIndicator(context));
    }
    return _buildIndicator(context);
  }

  _buildIndicator(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: dimension ?? AppDimens.icon40,
        child: const CircularProgressIndicator(
          color: Color(0xFF2A45FF),
        ),
      ),
    );
  }
}

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.primary.withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppLoadingIndicator(),
          const VSpacing(),
          if (message != null) ...{
            Text(
              message!,
              style: context.myTheme.textThemeT1.light.copyWith(color: context.myTheme.colorScheme.textBtnColor),
              textAlign: TextAlign.center,
            )
          }
        ],
      ),
    );
  }
}

class AppLoadingController {
  final params = ValueNotifier<AppLoadingControllerParams>(
    AppLoadingControllerParams(visible: false, hasBlurBackground: true, message: null),
  );

  showLoading({bool blurBG = true, String? msg}) {
    params.value = params.value.copyWith(
      visible: true,
      hasBlurBackground: blurBG,
      message: msg,
    );
  }

  hideLoading() {
    params.value = params.value.copyWith(visible: false);
  }
}

class AppLoadingControllerParams {
  final bool visible;
  final bool hasBlurBackground;
  final String? message;

  AppLoadingControllerParams({
    required this.visible,
    required this.hasBlurBackground,
    required this.message,
  });

  AppLoadingControllerParams copyWith({
    bool? visible,
    bool? hasBlurBackground,
    String? message,
  }) {
    return AppLoadingControllerParams(
      visible: visible ?? this.visible,
      hasBlurBackground: hasBlurBackground ?? this.hasBlurBackground,
      message: message ?? this.message,
    );
  }
}

class AppLoadingHUD extends StatelessWidget {
  const AppLoadingHUD({Key? key, required this.child, required this.controller}) : super(key: key);

  final Widget child;
  final AppLoadingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ValueListenableBuilder<AppLoadingControllerParams>(
            valueListenable: controller.params,
            builder: (context, visible, child) {
              return Visibility(
                  visible: controller.params.value.visible,
                  child: AppLoadingWidget(
                    message: controller.params.value.message,
                  ));
            })
      ],
    );
  }
}
