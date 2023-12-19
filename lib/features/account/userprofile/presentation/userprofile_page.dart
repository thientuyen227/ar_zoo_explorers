import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_cubit.dart';
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app/config/app_router.gr.dart';
import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../base/widgets/page_loading_indicator.dart';
import '../../../../core/data/controller/auth_controller.dart';
import '../../../../utils/widget/button_widget.dart';

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
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Trang cá nhân',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              actions: const [SizedBox(width: 55)],
              leading: AppIconButton(
                  onPressed: () {
                    context.router.pushNamed(Routes.home);
                  },
                  icon: Transform.scale(
                      scale: 1.5,
                      child: Image.asset(AppIcons.icBack_png, height: 55)))),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: controller.getCurrentUser(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(children: [
                    profileHeader(),
                    userInformation(context),
                  ]);
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
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.21,
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.16,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
              image: const DecorationImage(
                  image: AssetImage(AppImages.imgAppLogoBG),
                  fit: BoxFit.cover))),
      Positioned(
          left: 0, right: 0, bottom: 0, child: Center(child: userAvatar())),
    ]);
  }

  Widget userInformation(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ],
            ),
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(15.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "THÔNG TIN CÁ NHÂN",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              userInformationCustom(context),
              Container(height: 2, width: double.infinity, color: Colors.grey),
              updateInformation(),
            ])));
  }

  Widget userInformationCustom(BuildContext context) {
    return Column(children: [
      userInformationItem(
          context, "Họ và tên", controller.currentUser.value.fullname),
      const SizedBox(height: 13),
      userInformationItem(
          context, "Ngày sinh", controller.currentUser.value.birth),
      const SizedBox(height: 13),
      userInformationItem(context, "Giới tính",
          cubit.getGender(controller.currentUser.value.gender)),
      const SizedBox(height: 13),
      userInformationItem(
          context, "Địa chỉ email", controller.currentUser.value.email),
      const SizedBox(height: 13),
      userInformationItem(
          context, "Số điện thoại", controller.currentUser.value.phone),
      const SizedBox(height: 13),
      userInformationItem(
          context, "Địa chỉ", controller.currentUser.value.address),
      const SizedBox(height: 13)
    ]);
  }

  Widget updateInformation() {
    return Center(
        child: MaterialButton(
            onPressed: () {
              context.router.popAndPush(const UserInformationRoute());
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Thay đổi thông tin",
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

  Widget userInformationItem(
      BuildContext context, String title, String content) {
    String showContent = content;
    if (content == '') {
      showContent = "Chưa cập nhật";
    }
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start),
            ),
          ),
          Expanded(
              flex: 5,
              child: Text(showContent,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      fontStyle: FontStyle.italic))),
        ]));
  }

  Widget userAvatar() {
    return Container(
        width: MediaQuery.of(context).size.height * 0.155,
        height: MediaQuery.of(context).size.height * 0.155,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 5),
            shape: BoxShape.circle),
        child: ClipOval(
          child: (cubit.userAvatar == "")
              ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
              : Image.network(cubit.userAvatar, fit: BoxFit.cover),
        ));
  }

  @override
  void initState() {
    super.initState();
    cubit.setUserAvatar(controller.currentUser.value.avatarUrl);
  }
}
