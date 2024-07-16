import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../base/widgets/page_loading_indicator.dart';
import '../../../../core/data/controller/auth_controller.dart';
import '../../../base-model/form_builder_text_field_model.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ChangePasswordState, ChangePasswordCubit,
    ChangePasswordPage> {
  final controller = AuthController.findOrInitialize;
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget buildByState(BuildContext context, ChangePasswordState state) {
    return Obx(() => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: PageLoadingIndicator(
            future: controller.loginFuture.value,
            scaffold: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: AppColor.appBarColor,
                    title: Text(LanguageKeys.changePassword.tr.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.white,
                            fontWeight: FontWeight.bold)),
                    leading: const Column(children: [CustomBackButton()]),
                    actions: const []),
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
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                appLogo(),
                                const SizedBox(height: 60),
                                //NHẬP MẬT KHẨU CŨ
                                passwordForm(cubit.ListFormItem[0], 0),
                                // NHẬP MẬT KHẨU MỚI
                                passwordForm(cubit.ListFormItem[1], 1),
                                // NHẬP LẠI MẬT KHẨU MỚI
                                passwordForm(cubit.ListFormItem[2], 2),
                                const SizedBox(height: 15),
                                FutureBuilder(
                                    future: null,
                                    builder: (context, snapshot) => Align(
                                          child:
                                              submitButton(context, snapshot),
                                        ))
                              ]))),
                )),
          ),
        ));
  }

  Widget passwordForm(FormBuilderTextFieldModel items, int index) {
    return Column(children: [
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.all(10)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: LanguageKeys.requiredField.tr),
            (value) {
              return _onHandleValidator(index, value);
            }
          ])),
      const SizedBox(height: 20),
    ]);
  }

  Widget submitButton(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return ElevatedButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? () => _onUpdatePassword(context)
            : () => {
                  Fluttertoast.showToast(msg: LanguageKeys.updating.tr),
                  _onUpdatePassword(context)
                },
        style: ButtonStyle(
            fixedSize: WidgetStateProperty.all(const Size(160, 50)),
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            elevation: WidgetStateProperty.all(5),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(AppIcons.icWhiteSubmit),
          Text(LanguageKeys.change.tr.toUpperCase(),
              style: const TextStyle(fontSize: 18, color: AppColor.white))
        ]));
  }

  Widget appLogo() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 30),
      Transform.scale(
        scale: 2,
        child: Image.asset(
          AppImages.imgAppLogo,
          height: cubit.HEIGHT * 0.12,
          width: cubit.HEIGHT * 0.12,
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }

  Future<void> _onUpdatePassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await controller.changePassword(
          context,
          _formKey.currentState!.fields['oldPassword']?.value,
          _formKey.currentState!.fields['password']?.value);
      context.router.pushNamed(Routes.home);
    }
  }

  String? _onHandleValidator(int index, String? value) {
    String? confirmPassword = _formKey.currentState!.fields['password']!.value;
    switch (index) {
      case 1:
        return cubit.onCheckPassword(value);
      case 2:
        return cubit.onCheckConfirmPassword(value, confirmPassword);
      default:
        return null;
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
