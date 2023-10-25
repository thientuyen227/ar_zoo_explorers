import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../base/widgets/page_loading_indicator.dart';
import '../../../../utils/widget/button_widget.dart';
import '../../../base-model/FormBuilderTextField_Model.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<RegisterState, RegisterCubit, RegisterPage> {
  String txtFullName = "";
  String txtEmail = "";
  final controller = AuthController();
  final _formKey = GlobalKey<FormBuilderState>();
  String txtFullname = "";
  String txtUsername = "";
  String txtPassword = "";
  String txtConfirmPassword = "";
  bool isVisible = true;
  bool isConfirmVisible = true;
  bool isApproved = false;

  @override
  Widget buildByState(BuildContext context, RegisterState state) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Transform.scale(
                scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                child: Image.asset(AppImages.imgAppLogo, height: 55)),
            leading:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              AppIconButton(
                  onPressed: () {
                    context.router.pushNamed(Routes.login);
                  },
                  icon: Transform.scale(
                      scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                      child: Image.asset(AppIcons.icBack_png, height: 55)))
            ])),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: Column(children: [
                  const SizedBox(height: 20),
                  TitlePage(),
                  const SizedBox(height: 30),
                  fbtfTextNormal(
                      "Họ và tên*",
                      FormBuilderTextFieldModel(
                          name: "FullName",
                          txtValue: txtFullName,
                          hint_text: "Nguyễn Văn A",
                          icon_prefix: AppIcons.icUser,
                          isObscured: false,
                          TIT: TextInputType.text)),
                  const SizedBox(height: 15),
                  fbtfTextNormal(
                      "Email*",
                      FormBuilderTextFieldModel(
                          name: "Email",
                          txtValue: txtEmail,
                          hint_text: "Địa chỉ Email",
                          icon_prefix: AppIcons.icMail,
                          isObscured: false,
                          TIT: TextInputType.emailAddress)),
                  const SizedBox(height: 15),
                  TextPassword(FormBuilderTextFieldModel(
                      name: 'Password',
                      txtValue: txtPassword,
                      hint_text: 'Bao gồm: a...z, A...Z, 0...9, *@#...',
                      icon_prefix: AppIcons.icLock,
                      isObscured: isVisible)),
                  const SizedBox(height: 15),
                  ConfirmPassword(FormBuilderTextFieldModel(
                      name: 'ConfirmPassword',
                      txtValue: txtConfirmPassword,
                      hint_text: 'Nhập lại mật khẩu',
                      icon_prefix: AppIcons.icLock,
                      isObscured: isConfirmVisible)),
                  const SizedBox(height: 15),
                  AcceptWithRules(),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [SubmitButton()])
                ]))));
  }

  Widget TitlePage() {
    return Container(
        width:
            MediaQuery.of(context).size.width * 0.8, // Chiều ngang 80% màn hình
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, // Màu nền của Container
            border: Border.all(
                color: Colors.grey, // Màu viền
                width: 1.5), // Độ dày của viền
            borderRadius: // Độ cong góc của Container
                BorderRadius.circular(15.0)),
        child: const Center(
          child: Text("Đăng ký",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blue,
                  fontFamily: 'Times New Roman')),
        ));
  }

  Widget fbtfTextNormal(String title, FormBuilderTextFieldModel items,
      {BuildContext? context}) {
    return Obx(() => GestureDetector(
          onTap: () => FocusScope.of(context!).requestFocus(FocusNode()),
          child: PageLoadingIndicator(
            future: controller.signUpFuture.value,
            scaffold: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: const Text("Đăng ký",
                        style: TextStyle(
                            fontSize: 20, color: Colors.yellowAccent)),
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppIconButton(
                              onPressed: () {
                                context?.router.pushNamed(Routes.login);
                              },
                              icon: Transform.scale(
                                  scale:
                                      1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                                  child: Image.asset(AppImages.imgAppLogo,
                                      height: 55)))
                        ])),
                body: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 25),
                          child: Column(children: [
                            const SizedBox(height: 12),
                            Transform.scale(
                                scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                                child: Image.asset(AppImages.imgAppLogo,
                                    height: 250)),
                            TextFullName(FormBuilderTextFieldModel(
                                name: 'fullname',
                                hint_text: "Tên đăng nhập",
                                icon_prefix: AppIcons.icUser,
                                isObscured: false)),
                            const SizedBox(height: 12),
                            TextEmail(FormBuilderTextFieldModel(
                                name: 'username',
                                txtValue: txtUsername,
                                hint_text: "Tên đăng nhập",
                                icon_prefix: AppIcons.icUser,
                                isObscured: false)),
                            const SizedBox(height: 12),
                            TextPassword(FormBuilderTextFieldModel(
                                name: 'password',
                                txtValue: txtPassword,
                                hint_text: 'Mật khẩu',
                                icon_prefix: AppIcons.icLock,
                                isObscured: isVisible)),
                            const SizedBox(height: 12),
                            ConfirmPassword(FormBuilderTextFieldModel(
                                name: 'confirmpassword',
                                txtValue: txtConfirmPassword,
                                hint_text: 'Nhập lại mật khẩu',
                                icon_prefix: AppIcons.icLock,
                                isObscured: isConfirmVisible)),
                            const SizedBox(height: 15),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [SubmitButton()])
                          ]))),
                )),
          ),
        ));
  }

  Widget TextFullName(FormBuilderTextFieldModel items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 20),
        Text("Họ và tên",
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

  Widget TextEmail(FormBuilderTextFieldModel items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 20),
        Text("Email",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 5),
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: items.TIT,
          onChanged: (value) {
            setState(() {
              items.txtValue = value!;
            });
          },
          decoration: InputDecoration(
              hintText: items.hint_text,
              prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(10)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(errorText: "")]))
    ]);
  }

  Widget TextPassword(FormBuilderTextFieldModel items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 18),
        Text("Mật khẩu*",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic))
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
        Text("Xác nhận mật khẩu*",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic))
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

  Widget AcceptWithRules() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Checkbox(
          value: isApproved,
          onChanged: (value) {
            setState(() {
              isApproved = value!;
            });
          }),
      const Text("Tôi đồng ý với",
          style: TextStyle(fontSize: 20, color: Colors.black)),
      const SizedBox(width: 5),
      GestureDetector(
          onTap: () {
            _TurnPage();
          },
          child: const Text('điều khoản sử dụng',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Colors.blue, // Màu chữ
                  decoration: TextDecoration.none // Gạch chân chữ
                  )))
    ]);
  }

  Widget SubmitButton() {
    return ElevatedButton(
        onPressed: () {
          context.router.pushNamed(Routes.userprofile);
        },
        style: TextButton.styleFrom(
            minimumSize: const Size(160, 50),
            backgroundColor: Colors.green, // Màu nền
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10), // Khoảng cách giữa chữ và nút
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30) // Đổ viền cho nút
                )),
        child: Row(children: [
          Image.asset(AppIcons.icWhiteSubmit),
          const SizedBox(width: 5),
          const Text("Đăng ký",
              style: TextStyle(fontSize: 20, color: Colors.white))
        ]));
  }

  void _TurnPage() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return const AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: 1.0, // Độ mờ 80%
              child: TermOfServicePage());
        }));

    void _signUp() async {
      if (_formKey.currentState!.validate()) {
        controller.signUp(
          fullname: _formKey.currentState!.fields['fullname']!.value,
          email: _formKey.currentState!.fields['email']!.value,
          // phone: _formKey.currentState!.fields['phone']!.value,
          password: _formKey.currentState!.fields['password']!.value,
          fromOnboard: Get.parameters['from_onboard']?.isEmpty ?? true,
        );
      }
    }
  }
}
