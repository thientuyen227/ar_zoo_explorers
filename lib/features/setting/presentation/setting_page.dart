import 'package:ar_zoo_explorers/features/setting/model/setting_type.dart';
import 'package:ar_zoo_explorers/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../app/config/routes.dart';
import '../../../app/theme/dimens.dart';
import '../../../base/base_state.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../model/setting_item.dart';
import 'setting_cubit.dart';
import 'setting_state.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<SettingState, SettingCubit, SettingPage> {
  @override
  Widget buildByState(BuildContext context, SettingState state) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          context.router.pop();
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.6)),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Scaffold(
              appBar: AppBar(
                title: const Text("Settings",
                    style: TextStyle(fontSize: 20, color: Colors.yellow)),
                centerTitle: false,
              ),
              body: Column(children: [
                const SizedBox(height: 20),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final item = cubit.settingItems[index];
                          return _buildSettingItem(item);
                        },
                        separatorBuilder: (context, index) =>
                            const VSpacing(spacing: AppDimens.spacing24),
                        itemCount: cubit.settingItems.length))
              ])))
    ]);
  }

  Widget _buildSettingItem(SettingItem item) {
    switch (item.type) {
      case SettingType.ads:
        return const SizedBox.shrink();
      default:
        return GestureDetector(
            onTap: () {
              _onTapSettings(item.type);
            },
            child: Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: AppDimens.spacing24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimens.radius20),
                    color: context.myTheme.colorScheme.cardColor),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spacing24,
                    vertical: AppDimens.spacing24),
                child: Row(children: [
                  Container(
                      width: 35,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black54),
                      padding: const EdgeInsets.all(AppDimens.spacing9),
                      child: Image.asset(item.icon!,
                          color: Colors.white, fit: BoxFit.scaleDown)),
                  const SizedBox(width: 18),
                  Text(item.title,
                      style: context.myTheme.textThemeT1.title
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                  const Expanded(child: SizedBox.shrink()),
                  const Icon(Icons.arrow_forward_ios_outlined,
                      size: AppDimens.icon18)
                ])));
    }
  }

  Future<void> _onTapSettings(SettingType type) async {
    switch (type) {
      case SettingType.shareApp:
        Share.share('');
        break;
      case SettingType.rateUs:
      case SettingType.privacyPolicy:
        launchUrlString(cubit.appConfig.privacyPolicyLink);
        break;
      case SettingType.contactUs:
        cubit.contactUs();
        break;
      case SettingType.manageSubscription:
        cubit.openManageSubscription();
        break;
      case SettingType.accountmanager:
        context.router.pushNamed(Routes.accountmanager);
        break;
      case SettingType.changeLanguage:
        context.router.pushNamed(Routes.changelanguage);
        break;
      default:
    }
  }
}
