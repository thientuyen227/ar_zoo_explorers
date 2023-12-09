import 'package:android_intent_plus/android_intent.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/setting/presentation/setting_state.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:injectable/injectable.dart';

import '../model/setting_item.dart';
import '../model/setting_type.dart';

@injectable
class SettingCubit extends BaseCubit<SettingState> {
  SettingCubit() : super(SettingState());

  final List<SettingItem> settingItems = [
    SettingItem(
        type: SettingType.accountmanager,
        title: "Account Manager",
        icon: AppIcons.icUser),
    SettingItem(
        type: SettingType.contactUs,
        title: "Contact Us",
        icon: AppIcons.icContactUs),
    SettingItem(
        type: SettingType.privacyPolicy,
        title: "Privacy Policy",
        icon: AppIcons.icPrivacyPolicy),
    SettingItem(
        type: SettingType.manageSubscription,
        title: "Manage Subscription",
        icon: AppIcons.icManageSubcription),
    SettingItem(
        type: SettingType.rateUs, title: "Rate Us", icon: AppIcons.icRateUs),
    SettingItem(
        type: SettingType.shareApp,
        title: "Share App",
        icon: AppIcons.icShareApp),
  ];

  void openManageSubscription() {
    final intent = AndroidIntent(
        action: "action_view",
        data:
            "https://play.google.com/store/account/subscriptions?&package=${appConfig.packageName}");
    intent.launch();
  }

  void contactUs() async {
    final Email email = Email(
      body: '',
      subject: '[AOS] ${appConfig.appName}',
      recipients: [appConfig.supportedEmail],
      isHTML: true,
    );

    await FlutterEmailSender.send(email);
  }
}
