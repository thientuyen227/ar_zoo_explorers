import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
                title: const Text("NHẬP MẬT KHẨU MỚI",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Column(children: [TurnBack()]),
                actions: const []),
            body: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
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
                              ]),
                          margin: const EdgeInsets.all(20.0),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 25),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //NHẬP MẬT KHẨU CŨ
                                PasswordForm(cubit.ListFormItem[0], 0),
                                // NHẬP MẬT KHẨU MỚI
                                PasswordForm(cubit.ListFormItem[1], 1),
                                // NHẬP LẠI MẬT KHẨU MỚI
                                PasswordForm(cubit.ListFormItem[2], 2),
                                const SizedBox(height: 15),
                                FutureBuilder(
                                    future: null,
                                    builder: (context, snapshot) => Align(
                                          child:
                                              SubmitButton(context, snapshot),
                                        ))
                              ]))),
                )),
          ),
        )));
  }

  Widget TurnBack() {
    return ElevatedButton(
        onPressed: () {
          context.router.pop();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)))),
        child: Image.asset(AppIcons.icBack_png));
  }

  Widget PasswordForm(FormBuilderTextFieldModel items, int index) {
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

  Widget SubmitButton(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return ElevatedButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? () => _onUpdatePassword(context)
            : () => {
                  Fluttertoast.showToast(msg: "Đang cập nhật"),
                  _onUpdatePassword(context)
                },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(140, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(AppIcons.icWhiteSubmit),
          const Text("Thay đổi", style: TextStyle(fontSize: 18))
        ]));
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
}
