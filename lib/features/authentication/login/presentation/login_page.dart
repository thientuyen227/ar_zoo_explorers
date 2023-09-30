import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/dimens.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<LoginState, LoginCubit, LoginPage> {
  @override
  Widget buildByState(BuildContext context, LoginState state) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Đăng nhập",
              style: TextStyle(fontSize: 20, color: Colors.yellowAccent)),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIconButton(
                onPressed: () {
                  context.router.pushNamed(Routes.settings);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                borderRadius: AppDimens.radius200,
                padding: const EdgeInsets.all(AppDimens.spacing5),
                width: AppDimens.size30.width,
                height: AppDimens.size30.height,
                backgroundColor: AppColorScheme.dark().cardColor,
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIconButton(
                    onPressed: () {
                      // context.router.pushNamed(Routes.);
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    borderRadius: AppDimens.radius200,
                    padding: const EdgeInsets.all(AppDimens.spacing5),
                    width: AppDimens.size30.width,
                    height: AppDimens.size30.height,
                    backgroundColor: AppColorScheme.dark().cardColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  const SizedBox(
                    height: 12,
                  ),
                  FormBuilderTextField(
                    name: 'Username',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Tên đăng nhập",
                        prefixIcon: Image.asset(
                          AppIcons.icUser,
                          height: 20,
                          width: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.all(10)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: ""),
                    ]),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FormBuilderTextField(
                    name: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Mật khẩu",
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.all(10)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: ""),
                    ]),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextButton(
                      onPressed: () {
                        context.router.pushNamed(Routes.home);
                      },
                      child: const Text("Submit",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              backgroundColor: Colors.blue)))
                ]))));
  }

  // void _login() {
  //   final username = _usernameController.text;
  //   final password = _passwordController.text;

  //   // Simulate a login request (replace with your actual authentication logic)
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() {
  //       _isLoading = false;
  //     });

  //     if (username == 'admin' && password == 'password') {
  //       // Đăng nhập thành công
  //       _showSnackBar('Đăng nhập thành công!');
  //     } else {
  //       // Đăng nhập thất bại
  //       _showSnackBar('Đăng nhập thất bại. Vui lòng kiểm tra lại!');
  //     }
  //   });
  // }

  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   _usernameController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }
}
