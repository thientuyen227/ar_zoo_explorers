import 'package:ar_zoo_explorers/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';
import 'image_widget.dart';

enum NavigationType { favorite, voice, camera, file, history }

class NavigationItem {
  String icon;
  NavigationType type;
  NavigationItem({
    required this.icon,
    required this.type,
  });
}

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function(NavigationType type) onTap;

  final List<NavigationItem> items = [
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom,
            decoration: BoxDecoration(
                color: context.myTheme.colorScheme.cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppDimens.radius16), topRight: Radius.circular(AppDimens.radius16))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items.map((e) {
              switch (e.type) {
                case NavigationType.camera:
                  return const SizedBox(
                    width: 67,
                    height: double.infinity,
                  );
                case NavigationType.voice:
                case NavigationType.file:
                  return DecoratedBox(
                    decoration: const BoxDecoration(color: Color(0xFFCCE0FF), shape: BoxShape.circle),
                    child: AppImageWidget(
                      assetString: e.icon,
                      size: AppDimens.size40,
                      onPressed: () {
                        onTap(e.type);
                      },
                    ),
                  );
                default:
                  return AppImageWidget(
                    assetString: e.icon,
                    size: AppDimens.size40,
                    onPressed: () {
                      onTap(e.type);
                    },
                  );
              }
            }).toList(),
          )
        ],
      ),
    );
  }
}
