import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/config/routes.dart';
import '../../../../core/data/controller/auth_controller.dart';
import '../../login/model/OthersLoginButton_Model.dart';

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
                    title: const Text("ĐĂNG KÝ TÀI KHOẢN",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [turnBack()])),
                body: FormBuilder(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blue[600],
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3))
                                  ],
                                ),
                                margin: const EdgeInsets.all(20.0),
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, bottom: 25),
                                child: Column(children: [
                                  const SizedBox(height: 50),
                                  // ĐỊA CHỈ EMAIL
                                  textForm(cubit.ListFormItem[0],
                                      TextInputType.emailAddress, 0),
                                  // HỌ VÀ TÊN
                                  textForm(cubit.ListFormItem[1],
                                      TextInputType.text, 1),
                                  //NHẬP MẬT KHẨU
                                  passwordForm(cubit.ListFormItem[2], 2),
                                  // NHẬP LẠI MẬT KHẨU
                                  passwordForm(cubit.ListFormItem[3], 3),
                                  //ĐIỀU KHOẢN SỬ DỤNG
                                  termsOfUse(),
                                  const SizedBox(height: 20),
                                  FutureBuilder(
                                      future: controller.signUpFuture.value,
                                      builder: (context, snapshot) =>
                                          Align(child: submitButton(snapshot))),
                                  const SizedBox(height: 15),
                                  otherLoginTitle(),
                                  const SizedBox(height: 15),
                                  Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Column(
                                          children: listOtherLoginButton(
                                              cubit.listOthersLoginButton)))
                                ])))))))));
  }

  Widget submitButton(AsyncSnapshot<dynamic> snapshot) {
    return ElevatedButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? _onSignUpPressed
            : null,
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(140, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(AppIcons.icWhiteSubmit),
          const Text("Đăng ký", style: TextStyle(fontSize: 18))
        ]));
  }

  Widget textForm(
      FormBuilderTextFieldModel items, TextInputType type, int index) {
    return Column(children: [
      FormBuilderTextField(
          name: items.name,
          obscureText: items.isObscured,
          keyboardType: type,
          decoration: InputDecoration(
              hintText: items.hint_text,
              prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(10)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Không thể để trống"),
            (value) {
              return _onHandleValidator(index, value);
            }
          ])),
      const SizedBox(height: 20),
    ]);
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
            FormBuilderValidators.required(errorText: "Không thể để trống"),
            (value) {
              return _onHandleValidator(index, value);
            }
          ])),
      const SizedBox(height: 20),
    ]);
  }

  Widget termsOfUse() {
    return Row(children: [
      Checkbox(
          value: cubit.isChecked,
          onChanged: (value) {
            setState(() {
              cubit.isChecked = value!;
            });
          }),
      Text("Tôi đồng ý với ",
          style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      GestureDetector(
          onTap: () {
            context.router.pushNamed(Routes.termofservice);
          },
          child: Text("Điều Khoản Sử Dụng",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold)))
    ]);
  }

  Widget turnBack() {
    return ElevatedButton(
        onPressed: () => context.router.pushNamed(Routes.login),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)))),
        child: Image.asset(AppIcons.icBack_png));
  }

  Widget otherLoginButton(OthersLoginButtonModel items) {
    return SizedBox(
        height: 50,
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                side: BorderSide(width: 2, color: items.bdColor),
                backgroundColor: items.bgColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                shadowColor: Colors.grey),
            child: Row(children: [
              Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(items.icon, scale: 0.9)),
              const SizedBox(width: 15),
              Text(items.content,
                  style: TextStyle(fontSize: 16, color: items.colorText))
            ])));
  }

  List<Widget> listOtherLoginButton(List<OthersLoginButtonModel> list) {
    List<Widget> listWidget = [];
    for (int i = 0; i < list.length; i++) {
      listWidget.add(otherLoginButton(list[i]));
      if (i < (list.length - 1)) {
        listWidget.add(const SizedBox(height: 12));
      }
    }
    return listWidget;
  }

  Widget otherLoginTitle() {
    return Stack(alignment: Alignment.center, children: [
      Container(height: 2, width: double.infinity, color: Colors.grey),
      Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: Text('Đăng nhập bằng cách khác',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
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

  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      if (!cubit.isChecked) {
        Fluttertoast.showToast(msg: "Bạn chưa đồng ý với điều khoản");
      } else {
        controller.signUp(
            fullname: _formKey.currentState!.fields['fullname']!.value,
            email: _formKey.currentState!.fields['email']!.value,
            password: _formKey.currentState!.fields['password']!.value,
            fromOnboard: true);
      }
    }
  }
}
