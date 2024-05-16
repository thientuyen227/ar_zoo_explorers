import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_cubit.dart';
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_router.gr.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../base/widgets/page_loading_indicator.dart';
import '../../../../core/data/controller/auth_controller.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<UserProfileState, UserProfileCubit, UserProfilePage> {
  final controller = AuthController.findOrInitialize;

  @override
  Widget buildByState(BuildContext context, UserProfileState state) {
    return PageLoadingIndicator(
        future: controller.getCurrentUser(context),
        scaffold: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(LanguageKeys.userProfile.tr.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              leading: const CustomBackButton(),
              actions: [btnUpdate()]),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: controller.getCurrentUser(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height),
                      decoration: BoxDecoration(color: Colors.grey.shade50),
                      child: Column(children: [profileHeader()]));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ));
  }

  Widget profileHeader() {
    return Stack(children: [
      SizedBox(width: cubit.WIDTH, height: cubit.HEIGHT * 0.3),
      profileBackground(),
      Positioned(
          left: cubit.WIDTH * 0.05,
          bottom: cubit.HEIGHT * 0.04,
          child: Center(child: userAvatar())),
      Positioned(
          left: cubit.WIDTH * 0.38,
          bottom: cubit.HEIGHT * 0.1,
          child: Center(child: username())),
      Positioned(
          left: cubit.WIDTH * 0.38,
          top: cubit.HEIGHT * 0.21,
          child: Center(child: userEmailAddress())),
    ]);
  }

  Widget username() {
    return SizedBox(
        width: cubit.WIDTH * 0.55,
        child: Text(controller.currentUser.value.fullname,
            style: const TextStyle(
                color: AppColor.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2));
  }

  Widget userEmailAddress() {
    return SizedBox(
        width: cubit.WIDTH * 0.55,
        child: Text(controller.currentUser.value.email,
            style: const TextStyle(color: AppColor.black, fontSize: 17),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2));
  }

  Widget profileBackground() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0))),
        child: Column(children: [
          gradientBackground(cubit.HEIGHT * 0.13, cubit.WIDTH, 0,
              Colors.blue.shade800, Colors.blue.shade200),
          gradientBackground(cubit.HEIGHT * 0.07, cubit.WIDTH, 5,
              Colors.blue.shade200, Colors.blue.shade800)
        ]));
  }

  Widget gradientBackground(double height, double width, double borderRadius,
      Color topColor, Color bottomColor) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius)),
            gradient: LinearGradient(
                colors: [topColor, bottomColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
            // image: const DecorationImage(
            //     image: AssetImage(AppImages.imgAppLogoBG), fit: BoxFit.cover),
            ));
  }

  Widget updateInformation() {
    return Center(
        child: MaterialButton(
            onPressed: () {
              context.router.popAndPush(const UserInformationRoute());
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Update Information",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                child: Image.asset(AppIcons.icNext_png),
              )
            ])));
  }

  Widget userAvatar() {
    return Container(
        width: cubit.HEIGHT * 0.155,
        height: cubit.HEIGHT * 0.155,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 5),
            shape: BoxShape.circle),
        child: ClipOval(
          child: (cubit.userAvatar == "")
              ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
              : Image.network(cubit.userAvatar, fit: BoxFit.cover),
        ));
  }

  Widget btnUpdate() {
    return AppIconButton(
        onPressed: () {
          context.router.popAndPush(const UserInformationRoute());
        },
        icon: Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(AppIcons.icUpdate64White, fit: BoxFit.cover)));
  }

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.WIDTH = MediaQuery.of(context).size.width;
        cubit.HEIGHT = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDimension();
    cubit.setUserAvatar(controller.currentUser.value.avatarUrl);
  }
}
