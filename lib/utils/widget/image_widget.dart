
import 'package:ar_zoo_explorers/utils/extension/context_ext.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/theme/dimens.dart';
import 'loading_widget.dart';

class AppImageWidget extends StatelessWidget {
  final String assetString;
  final Color? color;
  final Size? size;
  final VoidCallback? onPressed;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const AppImageWidget({
    Key? key,
    required this.assetString,
    this.color,
    this.size,
    this.onPressed,
    this.fit,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressed != null ? onPressed!() : null,
        behavior: HitTestBehavior.translucent,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: _buildContent(context),
        ));
  }

  Widget _buildContent(BuildContext context) {
    if (assetString.contains('png')) {
      return Image.asset(
        assetString,
        color: color,
        height: size?.height,
        width: size?.width,
        fit: fit,
      );
    } else if (assetString.contains('svg')) {
      return SvgPicture.asset(
        assetString,
        color: color,
        height: size?.height,
        width: size?.width,
        fit: fit ?? BoxFit.contain,
      );
    }
    return const Text('Error!');
  }
}

class AppNetWorkImageWidget extends StatelessWidget {
  final String url;
  final Size? size;
  final VoidCallback? onPressed;
  final BoxFit? fit;
  final VoidCallback? onErrorImageTapped;

  const AppNetWorkImageWidget({
    Key? key,
    required this.url,
    this.size,
    this.onPressed,
    this.fit,
    this.onErrorImageTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed != null ? onPressed!() : (onErrorImageTapped == null ? null : onErrorImageTapped!()),
      child: FastCachedImage(
        url: url,
        width: size?.width,
        height: size?.height,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.error,
            color: context.myTheme.colorScheme.textColor,
            size: AppDimens.icon20,
          );
        },
        fit: fit ?? BoxFit.cover,
        loadingBuilder: (p0, p1) {
          return const AppLoadingIndicator(
            dimension: AppDimens.icon20,
          );
        },
      ),
    );
  }
}
