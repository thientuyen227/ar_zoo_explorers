import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/account/accountmanager/model/accountmanager_type.dart';
import 'package:ar_zoo_explorers/features/account/accountmanager/presentation/accountmanager_cubit.dart';
import 'package:ar_zoo_explorers/features/account/accountmanager/presentation/accountmanager_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';

@RoutePage()
class AccountManagerPage extends StatefulWidget {
  const AccountManagerPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<AccountManagerState, AccountManagerCubit,
    AccountManagerPage> {
  String urlAvatarUser = AppImages.imgProfile128x128;
  @override
  Widget buildByState(BuildContext context, AccountManagerState state) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: SizedBox(
                width: double.infinity,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Transform.scale(
                      scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                      child: Image.asset(AppImages.imgAppLogo, height: 45)),
                  const SizedBox(width: 15),
                  const Text('Quản lý tài khoản',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ])),
            actions: const [SizedBox(width: 45)],
            leading: AppIconButton(
                onPressed: () {
                  context.router.pushNamed(Routes.home);
                },
                icon: Transform.scale(
                    scale: 1.5,
                    child: Image.asset(AppIcons.icBack_png, height: 55)))),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [AccountManagerTitle(), AccountManagerBody()]))));
  }

  Widget AccountManagerTitle() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          color: Colors.lightBlue[50],
          //borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Transform.scale(
                  scale: 1, child: Image.asset(urlAvatarUser, height: 65)),
              const SizedBox(width: 20),
              const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nguyễn Văn A',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text('anguyenvan123@gmail.com',
                        style: TextStyle(fontSize: 16, color: Colors.black))
                  ])
            ])));
  }

  Widget AccountManagerBody() {
    return Container(
        width: MediaQuery.of(context).size.width,
        // constraints:
        //     BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
            child: Column(children: [
          OptionButton("Trang cá nhân", AppIcons.icDefaultUser,
              AccountManagerType.UserProfilePage),
          OptionButton("Đổi mật khẩu", AppIcons.icLock,
              AccountManagerType.ChangePassword),
          OptionButton("Điều khoản sử dụng", AppIcons.icTerm,
              AccountManagerType.ViewTerm),
          OptionButton("Sự kiện", AppIcons.icEvent, AccountManagerType.Event),
          OptionButton(
              "Đăng xuất", AppIcons.icLogout, AccountManagerType.Logout)
        ])));
  }

  Widget OptionButton(
      String optionContent, String optionIcon, AccountManagerType type) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10)),
        height: 65,
        child: TextButton(
            onPressed: () {
              _onTapSettings(type);
            },
            child: Row(children: [
              const SizedBox(width: 15),
              Image.asset(optionIcon, height: 24),
              const SizedBox(width: 24),
              Text(optionContent,
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]))
            ])));
  }

  Future<void> _onTapSettings(AccountManagerType type) async {
    switch (type) {
      case AccountManagerType.UserProfilePage:
        context.router.pushNamed(Routes.home);
        break;
      case AccountManagerType.Logout:
        context.router.pushNamed(Routes.login);
        break;
      case AccountManagerType.ChangePassword:
        print("Chưa có");
      case AccountManagerType.ViewTerm:
        print("Chưa có");
      case AccountManagerType.Event:
        print("Chưa có");
      default:
    }
  }
}
