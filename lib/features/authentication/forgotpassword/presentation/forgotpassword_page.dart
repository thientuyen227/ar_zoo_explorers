import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/authentication/forgotpassword/presentation/forgotpassword_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/forgotpassword/presentation/forgotpassword_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/widgets/page_loading_indicator.dart';
import '../../../../core/data/controller/auth_controller.dart';
import '../../../base-model/form_builder_text_field_model.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ForgotPasswordState, ForgotPasswordCubit,
    ForgotPasswordPage> {
  final controller = AuthController.findOrInitialize;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildByState(BuildContext context, ForgotPasswordState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
          future: controller.loginFuture.value,
          scaffold: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text("QUÊN MẬT KHẨU",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Column(children: [turnBack()]),
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
                            ],
                          ),
                          margin: const EdgeInsets.all(20.0),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 25),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                emailForm(FormBuilderTextFieldModel(
                                    name: 'email',
                                    hint_text: "user123@gmail.com",
                                    icon_prefix: AppIcons.icUser,
                                    isObscured: false)),
                                const SizedBox(height: 20),
                                sendEmailButton(context)
                              ]))),
                )),
          ),
        )));
  }

  Widget emailForm(FormBuilderTextFieldModel items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 15),
        Text("Nhập địa chỉ email tại đây",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 10),
      FormBuilderTextField(
        name: items.name,
        valueTransformer: (suggestion) => suggestion,
        decoration: InputDecoration(
            hintText: items.hint_text,
            labelText: "email",
            prefixIcon: Image.asset(items.icon_prefix, height: 20, width: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.all(10)),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: "Hãy nhập email"),
          FormBuilderValidators.email()
        ]),
      ),
      const SizedBox(height: 12),
    ]);
  }

  Widget sendEmailButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          _resetPassword(context);
          //context.router.pushNamed(Routes.resetpassword);
        },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(140, 43)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: const Text("SEND CODE",
            style: TextStyle(fontSize: 16, color: Colors.white)));
  }

  Widget turnBack() {
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

  void _resetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      controller.sendPasswordResetEmail(
          context, _formKey.currentState!.fields['email']!.value);
    }
  }
}
