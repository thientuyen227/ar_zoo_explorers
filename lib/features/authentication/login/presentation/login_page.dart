import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/features/authentication/login/model/OthersLoginButton_Model.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_state.dart';
import 'package:ar_zoo_explorers/features/base-model/FormBuilderTextField_Model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/config/routes.dart';
import '../../../../core/data/controller/auth_controller.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<LoginState, LoginCubit, LoginPage> {
  final controller = AuthController();
  final _formKey = GlobalKey<FormBuilderState>();
  String txtUsername = "";
  String txtPassword = "";
  bool isVisible = true;
  bool isLoading = false;
  bool isChecked = false;
  List<OthersLoginButtonModel> listOthersLoginButton = [
    OthersLoginButtonModel(
        bgColor: Colors.red,
        bdColor: Colors.red,
        colorText: Colors.white,
        icon: AppIcons.icGMail,
        content: "Đăng nhập với GMail"),
    OthersLoginButtonModel(
        bgColor: Colors.blue,
        bdColor: Colors.blue,
        colorText: Colors.white,
        icon: AppIcons.icFacebook,
        content: "Đăng nhập với Facebook"),
    OthersLoginButtonModel(
        bgColor: Colors.white,
        bdColor: Colors.grey,
        colorText: Colors.black,
        icon: AppIcons.icApple,
        content: "Đăng nhập với ID Apple")
  ];

  @override
  Widget buildByState(BuildContext context, LoginState state) {
    return Obx(() => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: PageLoadingIndicator(
            future: controller.loginFuture.value,
            scaffold: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: const Text("Đăng nhập",
                        style: TextStyle(
                            fontSize: 20, color: Colors.yellowAccent)),
                    leading: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [])),
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
                            const SizedBox(height: 12),
                            TextEmail(FormBuilderTextFieldModel(
                                name: 'email',
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
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [RememberPass(), ForgotPassword()]),
                            const SizedBox(height: 12),
                            FutureBuilder(
                              future: controller.loginFuture.value,
                              builder: (context, snapshot) => Align(
                                child: ElevatedButton(
                                  onPressed: snapshot.connectionState !=
                                          ConnectionState.waiting
                                      ? _onLoginPressed
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  child: const Text("Đăng nhập"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            GoToSignUp(),
                            const SizedBox(height: 15),
                            const Text("Đăng nhập bằng cách khác?",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            const SizedBox(height: 12),
                            Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Màu nền của Container
                                  border: Border.all(
                                      color: Colors.grey, // Màu viền
                                      width: 1.5 // Độ dày của viền
                                      ),
                                  borderRadius: BorderRadius.circular(
                                      15.0), // Độ cong góc của Container
                                ),
                                child: Column(
                                    children: ListOthersLoginButton(
                                        listOthersLoginButton)))
                          ]))),
                )),
          ),
        ));
  }

  Widget RememberPass() {
    return Row(children: [
      Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          }),
      const Text('Ghi nhớ mật khẩu',
          style: TextStyle(color: Colors.black, fontSize: 17)),
      const SizedBox(width: 20)
    ]);
  }

  Widget SubmitButton() {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            minimumSize: const Size(200, 50),
            backgroundColor: Colors.blue, // Màu nền
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // Khoảng cách giữa chữ và nút
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Đổ viền cho nút
            )),
        child: const Text("Submit",
            style: TextStyle(fontSize: 20, color: Colors.white)));
  }

  Widget TextEmail(FormBuilderTextFieldModel items) {
    return FormBuilderTextField(
      name: items.name,
      obscureText: items.isObscured,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: items.hint_text,
          prefixIcon: Image.asset(
            items.icon_prefix,
            height: 20,
            width: 20,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(10)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: ""),
      ]),
    );
  }

  Widget ForgotPassword() {
    return InkWell(
        onTap: () {
          //context.router.pushNamed(Routes.register);
          print("Chức năng này chưa có!");
        },
        child: const Text('Quên mật khẩu',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 19,
                color: Colors.grey, // Màu chữ
                decoration: TextDecoration.none // Gạch chân chữ
                )));
  }

  Widget GoToSignUp() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Bạn chưa có tài khoản?",
          style: TextStyle(fontSize: 20, color: Colors.black)),
      const SizedBox(width: 5),
      InkWell(
          onTap: () {
            context.router.pushNamed(Routes.register);
          },
          child: const Text('Đăng ký tại đây!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Colors.blue, // Màu chữ
                  decoration: TextDecoration.none // Gạch chân chữ
                  )))
    ]);
  }

  Widget OhtersLoginButton(OthersLoginButtonModel items) {
    return SizedBox(
        height: 50,
        //color: Colors.red,
        child: ElevatedButton(
            onPressed: () {
              _showSnackBar('Chưa có!');
            },
            style: ElevatedButton.styleFrom(
                side: BorderSide(
                    width: 2, // Độ dày của viền
                    color: items.bdColor // Màu của viền
                    ),
                backgroundColor: items.bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Bo góc với bán kính là 20.0
                ),
                shadowColor: Colors.grey), // Màu của bóng đổ
            // Các thuộc tính khác như backgroundColor, padding, textStyle, ...),
            child: Row(children: [
              Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.white, // Màu nền của container
                      borderRadius:
                          BorderRadius.circular(10) // Bo góc với bán kính là 10
                      ),
                  child: Image.asset(items.icon, scale: 0.9)),
              const SizedBox(width: 15),
              Text(items.content,
                  style: TextStyle(fontSize: 18, color: items.colorText))
            ])));
  }

  List<Widget> ListOthersLoginButton(List<OthersLoginButtonModel> list) {
    List<Widget> listWidget = [];
    for (int i = 0; i < list.length; i++) {
      listWidget.add(OhtersLoginButton(list[i]));
      if (i < (list.length - 1)) {
        listWidget.add(const SizedBox(height: 12));
      }
    }
    return listWidget;
  }

  Widget TextPassword(FormBuilderTextFieldModel items) {
    return FormBuilderTextField(
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
              icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility)),
          prefixIcon: Image.asset(
            items.icon_prefix,
            height: 20,
            width: 20,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(10)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: ""),
      ]),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      controller.login(
        email: _formKey.currentState!.fields['email']!.value,
        password: _formKey.currentState!.fields['password']!.value,
      );
    }
  }
}
