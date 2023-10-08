import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../utils/widget/button_widget.dart';
import '../../../base-model/FormBuilderTextField_Model.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<RegisterState, RegisterCubit, RegisterPage> {
  String txtUsername = "";
  String txtPassword = "";
  String txtConfirmPassword = "";
  bool isVisible = true;
  bool isConfirmVisible = true;

  @override
  Widget buildByState(BuildContext context, RegisterState state) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Đăng ký",
                style: TextStyle(fontSize: 20, color: Colors.yellowAccent)),
            leading:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              AppIconButton(
                  onPressed: () {
                    context.router.pushNamed(Routes.login);
                  },
                  icon: Transform.scale(
                      scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                      child: Image.asset(AppImages.imgAppLogo, height: 55)))
            ])),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: Column(children: [
                  const SizedBox(height: 12),
                  Transform.scale(
                      scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                      child: Image.asset(AppImages.imgAppLogo, height: 250)),
                  TextUserName(FormBuilderTextFieldModel(
                      name: 'UserName',
                      txtValue: txtUsername,
                      hint_text: "Tên đăng nhập",
                      icon_prefix: AppIcons.icUser,
                      isObscured: false)),
                  const SizedBox(height: 12),
                  TextPassword(FormBuilderTextFieldModel(
                      name: 'Password',
                      txtValue: txtPassword,
                      hint_text: 'Mật khẩu',
                      icon_prefix: AppIcons.icLock,
                      isObscured: isVisible)),
                  const SizedBox(height: 12),
                  ConfirmPassword(FormBuilderTextFieldModel(
                      name: 'ConfirmPassword',
                      txtValue: txtConfirmPassword,
                      hint_text: 'Nhập lại mật khẩu',
                      icon_prefix: AppIcons.icLock,
                      isObscured: isConfirmVisible)),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [LoginButton(), NextPageButton()])
                ]))));
  }

  Widget TextUserName(FormBuilderTextFieldModel items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 20),
        Text("Tên đăng nhập",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 5),
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            // Lấy giá trị từ TextField khi nó thay đổi
            setState(() {
              txtUsername = value!;
            });
          },
          decoration: InputDecoration(
              hintText: items.hint_text,
              prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(10)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: ""),
          ]))
    ]);
  }

  Widget TextPassword(FormBuilderTextFieldModel items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 20),
        Text("Mật khẩu",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 5),
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            // Lấy giá trị từ TextField khi nó thay đổi
            setState(() {
              txtPassword = value!;
            });
          },
          decoration: InputDecoration(
              hintText: items.hint_text,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                      print(isVisible);
                    });
                  },
                  icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility)),
              prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(10)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(errorText: "")]))
    ]);
  }

  Widget ConfirmPassword(FormBuilderTextFieldModel items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 20),
        Text("Xác nhận mật khẩu",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 5),
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            // Lấy giá trị từ TextField khi nó thay đổi
            setState(() {
              txtConfirmPassword = value!;
            });
          },
          decoration: InputDecoration(
              hintText: items.hint_text,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isConfirmVisible = !isConfirmVisible;
                      print(isConfirmVisible);
                    });
                  },
                  icon: Icon(isConfirmVisible
                      ? Icons.visibility_off
                      : Icons.visibility)),
              prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(10)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(errorText: "")]))
    ]);
  }

  Widget LoginButton() {
    return ElevatedButton(
        onPressed: () {
          context.router.pushNamed(Routes.login);
        },
        style: TextButton.styleFrom(
            minimumSize: const Size(160, 50),
            backgroundColor: Colors.blue, // Màu nền
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10), // Khoảng cách giữa chữ và nút
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30) // Đổ viền cho nút
                )),
        child: const Row(children: [
          Icon(Icons.arrow_back, color: Colors.white),
          SizedBox(width: 5),
          Text("Đăng nhập", style: TextStyle(fontSize: 20, color: Colors.white))
        ]));
  }

  Widget NextPageButton() {
    return ElevatedButton(
        onPressed: () {
          //context.router.pushNamed(Routes.login);
        },
        style: TextButton.styleFrom(
            minimumSize: const Size(160, 50),
            backgroundColor: Colors.green, // Màu nền
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10), // Khoảng cách giữa chữ và nút
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30) // Đổ viền cho nút
                )),
        child: const Row(children: [
          Text("Tiếp theo",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          SizedBox(width: 5),
          Icon(Icons.arrow_forward, color: Colors.white)
        ]));
  }
}
