import 'dart:io' show Platform;

import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/config/routes.dart';
import '../../../../core/data/controller/auth_controller.dart';

//FlutterToast
@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<RegisterState, RegisterCubit, RegisterPage> {
  final controller = AuthController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildByState(BuildContext context, RegisterState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: controller.signUpFuture.value,
            scaffold: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [backButton()]),
                  actions: [logoAction()],
                ),
                body: FormBuilder(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.only(
                                left: 35, right: 35, bottom: 50),
                            child: Column(children: [
                              const SizedBox(height: 30),
                              signUpHeader(),
                              // ĐỊA CHỈ EMAIL
                              textForm(cubit.ListFormItem[0],
                                  TextInputType.emailAddress, 0),
                              // HỌ VÀ TÊN
                              textForm(
                                  cubit.ListFormItem[1], TextInputType.text, 1),
                              //NHẬP MẬT KHẨU
                              passwordForm(cubit.ListFormItem[2], 2),
                              // NHẬP LẠI MẬT KHẨU
                              passwordForm(cubit.ListFormItem[3], 3),
                              //ĐIỀU KHOẢN SỬ DỤNG
                              termsOfUse(),
                              const SizedBox(height: 24),
                              FutureBuilder(
                                  future: controller.signUpFuture.value,
                                  builder: (context, snapshot) =>
                                      Align(child: submitButton(snapshot))),
                              const SizedBox(height: 24),
                              listOtherLoginButton(context)
                            ]))))))));
  }

  Widget backButton() {
    return AppIconButton(
      onPressed: () => context.router.pushNamed(Routes.login),
      icon: Container(
          margin: const EdgeInsets.only(left: 35),
          child: ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              child: Transform.scale(
                  scale: 1.5,
                  child: Image.asset(AppIcons.icBack_x64_png,
                      height: 24, width: 24)))),
    );
  }

  Widget logoAction() {
    return Container(
        margin: const EdgeInsets.only(right: 35),
        child: Transform.scale(
          scale: 1.9,
          child: Image.asset(AppImages.imgAppLogo, height: 40, width: 40),
        ));
  }

  Widget signUpHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width),
        primaryGradientText("Create your account !", 32.0),
        const SizedBox(height: 36),
      ],
    );
  }

  Widget primaryGradientText(String content, double size,
      {Color color = Colors.white}) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [Colors.blue.shade800, Colors.orange.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds);
        },
        child: Text(content,
            softWrap: true,
            style: TextStyle(
                fontSize: size, fontWeight: FontWeight.bold, color: color)));
  }

  Widget textForm(
      FormBuilderTextFieldModel items, TextInputType type, int index) {
    return Column(children: [
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: type,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              hintText: items.hint_text,
              prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(12)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Field cannot be empty"),
            (value) {
              return _onHandleValidator(index, value);
            }
          ])),
      const SizedBox(height: 24),
    ]);
  }

  Widget passwordForm(FormBuilderTextFieldModel items, int index) {
    return Column(children: [
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              hintText: items.hint_text,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      cubit.onChangeObscuredStatus(index);
                    });
                  },
                  icon: Icon(cubit.ListFormItem[index].isObscured
                      ? Icons.visibility_off
                      : Icons.visibility)),
              prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(12)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Field cannot be empty"),
            (value) {
              return _onHandleValidator(index, value);
            }
          ])),
      const SizedBox(height: 24),
    ]);
  }

  Widget termsOfUse() {
    return Row(children: [
      Checkbox(
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          value: cubit.isChecked,
          onChanged: (value) {
            setState(() {
              cubit.isChecked = value!;
            });
          }),
      Text("I understood the ",
          style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      GestureDetector(
          onTap: () {
            context.router.pushNamed(Routes.termofservice);
          },
          child: Text("term & policy",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold)))
    ]);
  }

  Widget otherLoginButton(BuildContext context, int index) {
    return GestureDetector(
        onTap: () => _onOthersLogin(index),
        child: Container(
            width: cubit.WIDTH * 0.14,
            height: cubit.WIDTH * 0.14,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                //border: Border.all(color: Colors.grey, width: 2),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            child: ClipRect(
                child: Image.asset(
                    cubit.listOthersLoginButton[index].toString(),
                    fit: BoxFit.cover))));
  }

  Widget submitButton(AsyncSnapshot<dynamic> snapshot) {
    return ElevatedButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? _onSignUpPressed
            : null,
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(cubit.WIDTH * 0.6, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(AppIcons.icWhiteSubmit),
          const Text("Sign up",
              style: TextStyle(fontSize: 18, color: Colors.white))
        ]));
  }

  Widget listOtherLoginButton(BuildContext context) {
    List<Widget> lstButton = [
      otherLoginButton(context, 0),
      SizedBox(width: cubit.WIDTH * 0.1),
      otherLoginButton(context, 1)
    ];

    if (Platform.isIOS) {
      lstButton.add(SizedBox(width: cubit.WIDTH * 0.1));
      lstButton.add(otherLoginButton(context, 3));
    }
    return Column(children: [
      otherLoginTitle(),
      const SizedBox(height: 15),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: lstButton)
    ]);
  }

  Widget otherLoginTitle() {
    return Stack(alignment: Alignment.center, children: [
      Container(height: 2, width: double.infinity, color: Colors.grey),
      Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: Text('or sign up with',
              style: TextStyle(fontSize: 17, color: Colors.grey[700]),
              textAlign: TextAlign.center))
    ]);
  }

  String? _onHandleValidator(int index, String? value) {
    String? confirmPassword = _formKey.currentState!.fields['password']!.value;
    switch (index) {
      case 0:
        return cubit.onCheckEmail(value);
      case 1:
        return cubit.onCheckUsername(value);
      case 2:
        return cubit.onCheckPassword(value);
      case 3:
        return cubit.onCheckConfirmPassword(value, confirmPassword);
      default:
        return null;
    }
  }

  Future<void> _onOthersLogin(index) async {
    switch (index) {
      case 0:
        await controller.loginWithFacebook(context);
        break;
      case 1:
        await controller.loginWithGoogle(context);
        break;
      case 2:
        Fluttertoast.showToast(msg: "The feature will be updated later.");
        break;
      default:
        return;
    }
  }

  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      if (!cubit.isChecked) {
        Fluttertoast.showToast(msg: "You have not agreed to the terms!");
      } else {
        controller.signUp(context,
            fullname: _formKey.currentState!.fields['fullname']!.value,
            email: _formKey.currentState!.fields['email']!.value,
            password: _formKey.currentState!.fields['password']!.value,
            fromOnboard: true);
      }
    }
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
  }
}
