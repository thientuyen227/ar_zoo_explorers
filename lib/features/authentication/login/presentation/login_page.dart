import 'dart:io' show Platform;

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_state.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../app/config/routes.dart';
import '../../../../core/data/controller/auth_controller.dart';

//FlutterToast
@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<LoginState, LoginCubit, LoginPage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TextEditingController _textEditingController = TextEditingController();
  final controller = AuthController.findOrInitialize;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildByState(BuildContext context, LoginState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
          future: controller.loginFuture.value,
          scaffold: Scaffold(
            body: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height),
                      padding: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 50),
                      child: Column(children: [
                        const SizedBox(height: 12),
                        appLogo(),
                        loginHeader(),
                        emailForm(cubit.ListFormItem[0]),
                        passwordForm(cubit.ListFormItem[1]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [rememberPass(), forgotPassword()]),
                        const SizedBox(height: 24),
                        FutureBuilder(
                            future: controller.loginFuture.value,
                            builder: (context, snapshot) =>
                                Align(child: submitButton(context, snapshot))),
                        const SizedBox(height: 24),
                        listOtherLoginButton(context),
                        const SizedBox(height: 25),
                        register(),
                      ])),
                )),
          ),
        )));
  }

  Widget appLogo() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 48),
      Transform.scale(
        scale: 2,
        child: Image.asset(
          AppImages.imgAppLogo,
          height: cubit.HEIGHT * 0.25,
          width: cubit.WIDTH,
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }

  Widget loginHeader() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(width: MediaQuery.of(context).size.width),
        primaryGradientText(LanguageKeys.login.tr, 32.0),
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

  Widget emailForm(FormBuilderTextFieldModel items) {
    return Column(children: [
      FormBuilderTypeAhead(
        name: items.name,
        controller: _textEditingController,
        onChanged: (value) {
          List<String> filteredSuggestions = cubit.ListEmail;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(title: Text(suggestion));
        },
        suggestionsCallback: (pattern) async {
          _formKey.currentState!.fields['email']!
              .setValue(_textEditingController.text);
          return cubit.ListEmail.where(
              (suggestion) => suggestion.startsWith(pattern));
        },
        onSuggestionSelected: (suggestion) async {
          _formKey.currentState?.patchValue(
              {'password': await _secureStorage.read(key: suggestion ?? '')});
        },
        valueTransformer: (suggestion) => suggestion,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            hintText: items.hint_text,
            labelText: items.hint_text,
            prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.all(12)),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: LanguageKeys.formRequiredEmailError.tr),
          FormBuilderValidators.email()
        ]),
      ),
      const SizedBox(height: 16),
    ]);
  }

  Widget passwordForm(FormBuilderTextFieldModel items) {
    int index = 1;
    return Column(children: [
      FormBuilderTextField(
        name: items.name,
        obscureText: items.isObscured,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            labelText: items.hint_text,
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.all(12)),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: LanguageKeys.formShortPasswordError.tr),
        ]),
      ),
      const SizedBox(height: 24),
    ]);
  }

  Widget submitButton(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return ElevatedButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? () => _onLoginPressed(context)
            : null,
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(cubit.WIDTH * 0.6, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.blue[600]),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: const Text("Submit",
            style: TextStyle(fontSize: 20, color: Colors.white)));
  }

  Widget rememberPass() {
    return Row(children: [
      Checkbox(
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          value: cubit.isChecked,
          onChanged: (value) {
            setState(() {
              cubit.isChecked = value!;
            });
          },
          activeColor: Colors.blue[700]),
      const Text('Remember Me',
          style: TextStyle(color: Colors.black, fontSize: 15.5))
    ]);
  }

  Widget forgotPassword() {
    return GestureDetector(
        onTap: () {
          context.router.pushNamed(Routes.forgotpassword);
        },
        child: const Row(children: [
          Text('Forgot password',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 16.5,
                  color: Colors.grey,
                  decoration: TextDecoration.none)),
          SizedBox(width: 10)
        ]));
  }

  Widget register() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Don't have an account?",
          style: TextStyle(fontSize: 16.5, color: Colors.black)),
      const SizedBox(width: 7),
      GestureDetector(
          onTap: () {
            context.router.pushNamed(Routes.register);
          },
          child: const Text('SIGN UP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Colors.blue, // Màu chữ
                  decoration: TextDecoration.none // Gạch chân chữ
                  )))
    ]);
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

  Widget otherLoginButton(BuildContext context, int index) {
    return GestureDetector(
        onTap: () => _onLoginWithOtherOptions(context, index),
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

  //NÚT ĐĂNG KÝ TRÊN THANH APPBAR
  // Widget signUpAction() {
  //   return ElevatedButton(
  //       onPressed: () => context.router.pushNamed(Routes.register),
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all(Colors.blue),
  //           elevation: MaterialStateProperty.all(0),
  //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(0)))),
  //       child: Row(children: [
  //         const Text('Sign up',
  //             style: TextStyle(color: Colors.white, fontSize: 17)),
  //         Image.asset(AppIcons.icNext_png)
  //       ]));
  // }

  Future<void> _onLoginPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (cubit.isChecked) {
        await _savePassword(_formKey.currentState!.fields['email']!.value,
            _formKey.currentState!.fields['password']!.value);
      }
      controller.login(
        context: context,
        email: _formKey.currentState!.fields['email']!.value,
        password: _formKey.currentState!.fields['password']!.value,
      );
    }
  }

  Future<void> _onLoginWithOtherOptions(BuildContext context, int index) async {
    switch (index) {
      case 0:
        controller.loginWithFacebook(context);
        break;
      case 1:
        controller.loginWithGoogle(context);
        break;
      case 2:
        Fluttertoast.showToast(msg: "The feature will be updated later.");
        break;
      default:
        return;
    }
  }

  Future<void> _savePassword(String email, String password) async {
    await _secureStorage.write(key: email, value: password);
  }

  Future<void> _loadListEmail() async {
    Map<String, String> allValues = await _secureStorage.readAll();
    if (allValues != null || allValues.isNotEmpty) {
      cubit.ListEmail = allValues.keys.toList();
    } else {
      cubit.ListEmail = [];
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

  // Future<void> _loadSavedPassword() async {
  //   String? email = await _secureStorage.read(key: 'lastest' ?? '');
  //   String? savedPassword = await _secureStorage.read(key: email ?? '');
  //   if (savedPassword != null) {
  //     _formKey.currentState?.patchValue({
  //       'email': email,
  //       'password': savedPassword,
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();

    _loadListEmail();
    setDimension();
  }
}
