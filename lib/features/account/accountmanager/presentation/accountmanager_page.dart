import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/account/accountmanager/model/accountmanager_type.dart';
import 'package:ar_zoo_explorers/features/account/accountmanager/presentation/accountmanager_cubit.dart';
import 'package:ar_zoo_explorers/features/account/accountmanager/presentation/accountmanager_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../core/data/controller/auth_controller.dart';

@RoutePage()
class AccountManagerPage extends StatefulWidget {
  const AccountManagerPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<AccountManagerState, AccountManagerCubit,
    AccountManagerPage> {
  String urlAvatarUser = AppImages.imgProfile128x128;
  final controller = AuthController.findOrInitialize;

  @override
  Widget buildByState(BuildContext context, AccountManagerState state) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }

        if (context.mounted) {
          Navigator.pop(context);
          context.router.pushNamed(Routes.home);
        }
      },
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.appBarColor,
              title: Text(LanguageKeys.settings.tr.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold)),
              actions: const [SizedBox(width: 45)],
              leading: turnBack()),
          body: SingleChildScrollView(
              child: Container(
                  child: Column(children: [
            accountManagerTitle(),
            accountManagerBody(context)
          ])))),
    );
  }

  Widget accountManagerTitle() {
    return Container(
        color: const Color.fromARGB(255, 228, 224, 224),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.height * 0.135,
                      height: MediaQuery.of(context).size.height * 0.135,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blue.shade600, width: 5),
                          shape: BoxShape.circle),
                      child: userAvatar()),
                  Text(controller.currentUser.value.fullname,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ])));
  }

  Widget userAvatar() {
    return Container(
        width: MediaQuery.of(context).size.height * 0.155,
        height: MediaQuery.of(context).size.height * 0.155,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.white, width: 5),
            shape: BoxShape.circle),
        child: ClipOval(
          child: (controller.currentUser.value.avatarUrl == "")
              ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
              : Image.network(controller.currentUser.value.avatarUrl,
                  fit: BoxFit.cover),
        ));
  }

  Widget accountManagerBody(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 228, 224, 224),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
                child: Column(children: [
                  optionButton(
                      context,
                      LanguageKeys.userProfile.tr,
                      AppIcons.icUserProfile,
                      AccountManagerType.UserProfilePage),
                  optionButton(
                      context,
                      LanguageKeys.changePassword.tr,
                      AppIcons.icChangePassword,
                      AccountManagerType.ChangePassword),
                  const SizedBox(height: 15),
                  optionButton(context, LanguageKeys.notify.tr,
                      AppIcons.icAnnouncement, AccountManagerType.Announcement),
                  optionButton(context, LanguageKeys.event.tr, AppIcons.icEvent,
                      AccountManagerType.Event),
                  const SizedBox(height: 15),
                  optionButton(context, LanguageKeys.changeLanguage.tr,
                      AppIcons.icLanguage, AccountManagerType.ChangeLanguage),
                  optionButton(context, LanguageKeys.termsOfService.tr,
                      AppIcons.icTermsOfUse, AccountManagerType.ViewTerm),
                  optionButton(context, LanguageKeys.rating.tr,
                      AppIcons.icRating, AccountManagerType.RatingApplication),
                  optionButton(context, LanguageKeys.support.tr,
                      AppIcons.icHelp, AccountManagerType.Assistance),
                  const SizedBox(height: 15),
                  optionButton(context, LanguageKeys.logout.tr,
                      AppIcons.icLogout, AccountManagerType.Logout)
                ]))));
  }

  Widget optionButton(BuildContext context, String optionContent,
      String optionIcon, AccountManagerType type) {
    return Column(children: [
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
          child: ElevatedButton(
              onPressed: () {
                _onTapSettings(context, type);
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColor.white),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: Transform.scale(
                        scale: 1.25,
                        child: Image.asset(optionIcon, height: 24))),
                Expanded(
                    flex: 5,
                    child: Text(optionContent,
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black))),
                ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  child: Transform.scale(
                      scale: 1.15, child: Image.asset(AppIcons.icNext_png)),
                )
              ]))),
      const SizedBox(height: 3)
    ]);
  }

  Widget turnBack() {
    return CustomBackButton(onPressed: () {
      context.router.pushNamed(Routes.home);
      Navigator.of(context).pop(true);
    });
  }

  Future<void> _onTapSettings(
      BuildContext context, AccountManagerType type) async {
    switch (type) {
      case AccountManagerType.UserProfilePage:
        context.router.pushNamed(Routes.userprofile);
        break;
      case AccountManagerType.Logout:
        controller.logout(context);
        //context.router.pushNamed(Routes.welcome);
        break;
      case AccountManagerType.ChangePassword:
        context.router.pushNamed(Routes.changepassword);
      case AccountManagerType.Announcement:
        break;
      case AccountManagerType.ViewTerm:
        context.router.pushNamed(Routes.termofservice);
        break;
      case AccountManagerType.Event:
        break;
      case AccountManagerType.ChangeLanguage:
        context.router.pushNamed(Routes.changelanguage);
        break;
      case AccountManagerType.Assistance:
        context.router.pushNamed(Routes.help);
        break;
      default:
    }
  }
}
