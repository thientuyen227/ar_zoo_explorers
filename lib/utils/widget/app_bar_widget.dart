import 'package:ar_zoo_explorers/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';
import '../../app/theme/icons.dart';
import 'button_widget.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    Key? key,
    this.centerTitle,
    this.addCloseBtn = false,
    this.leading,
    this.trailing,
    this.title,
    this.backgroundColor,
    this.titleStyle,
    this.onDefaultClosePage,
    this.titleWidget
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, AppDimens.navigationBarHeight);
  final String? title;
  final Widget? titleWidget;
  final bool? centerTitle;
  final Widget? leading;
  final bool addCloseBtn;
  final List<Widget>? trailing;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final VoidCallback? onDefaultClosePage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacing15, vertical: AppDimens.spacing12),
      child: AppBar(
        backgroundColor: backgroundColor,
        title: title != null
            ? Text(title!,
                style: titleStyle ?? context.myTheme.textThemeT1.header2.copyWith(fontWeight: FontWeight.w700))
            : const SizedBox.shrink(),
        centerTitle: centerTitle ?? true,
        actions: trailing,
        leading: leading ??
            AppCircleButton(
                assetString: AppIcons.icBack,
                backgroundColor: context.myTheme.colorScheme.cardColor,
                onPressed: () => onDefaultClosePage != null ? onDefaultClosePage!() : context.router.popForced()),
        leadingWidth: AppDimens.backButton,
        elevation: 0,
      ),
    );
  }
}
