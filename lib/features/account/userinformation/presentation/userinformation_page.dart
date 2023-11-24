import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_cubit.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:internationalization/internationalization.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../core/data/controller/auth_controller.dart';
import '../../../../utils/widget/button_widget.dart';

@RoutePage()
class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<UserInformationState, UserInformationCubit,
    UserInformationPage> {
  final controller = AuthController.findOrInitialize;
  final _formKey = GlobalKey<FormBuilderState>();

  DateTime dtBirthday = DateTime.now();

  @override
  Widget buildByState(BuildContext context, UserInformationState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
          future: controller.signUpFuture.value,
          scaffold: Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: const Text('CHỈNH SỬA THÔNG TIN',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  actions: const [],
                  leading: TurnBack()),
              body: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    ProfileHeader(),
                    Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(children: [
                          TextForm("Họ và tên", 0,
                              controller.currentUser.value.fullname),
                          TextForm("Địa chỉ email", 1,
                              controller.currentUser.value.email),
                          DateForm(),
                          TextForm("Số điện thoại", 2,
                              controller.currentUser.value.phone),
                          TextForm("Địa chỉ", 3,
                              controller.currentUser.value.address),
                          TextForm("Công ty / Trường học", 4,
                              controller.currentUser.value.provider)
                        ])),
                    SubmitButton(context),
                    const SizedBox(height: 20),
                  ])))),
        )));
  }

  Widget TextForm(String title, int index, String? content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleForm(title),
      const SizedBox(height: 10),
      BodyForm(index, content),
      const SizedBox(height: 12),
    ]);
  }

  Widget TitleForm(String title) {
    return Row(children: [
      const SizedBox(width: 15),
      Text(title,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold))
    ]);
  }

  Widget BodyForm(int index, String? content) {
    return FormBuilderTextField(
      name: cubit.ListFormItem[index].name,
      initialValue: content,
      enabled: (cubit.ListFormItem[index].name == 'email') ? false : true,
      decoration: InputDecoration(
          hintText: cubit.ListFormItem[index].hint_text,
          labelText: cubit.ListFormItem[index].hint_text,
          prefixIcon: Image.asset(cubit.ListFormItem[index].icon_prefix,
              height: 20, width: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(10)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Không thể để trống"),
      ]),
    );
  }

  Widget ProfileHeader() {
    return Stack(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.21,
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.16,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
              image: const DecorationImage(
                  image: AssetImage(AppImages.imgAppLogoBG),
                  fit: BoxFit.cover))),
      Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.height * 0.15,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: AssetImage(AppImages.imgProfile128x128),
                          fit: BoxFit.cover))))),
    ]);
  }

  Widget TurnBack() {
    return AppIconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: Transform.scale(
            scale: 1.5, child: Image.asset(AppIcons.icBack_png, height: 55)));
  }

  Widget SubmitButton(
      BuildContext context /*, AsyncSnapshot<dynamic> snapshot*/) {
    return TextButton(
        onPressed: () {},
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(140, 43)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: const Text("CẬP NHẬT",
            style: TextStyle(fontSize: 16, color: Colors.white)));
  }

  Widget DateForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleForm("Ngày sinh"),
      const SizedBox(height: 10),
      TextFormField(
          onTap: () {
            _selectDate(context);
          },
          readOnly: true, // Đánh dấu ô nhập liệu là chỉ đọc
          controller: TextEditingController(
              text: DateFormat('dd/MM/yyyy')
                  .format(dtBirthday)), // Định dạng hiển thị
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Chọn ngày tháng',
              prefixIcon: Image.asset(AppIcons.icCalendar),
              contentPadding: const EdgeInsets.all(10))),
      const SizedBox(height: 12),
    ]);
  }

  String formatDateString(String value) {
    if (value.length == 8) {
      return '${value.substring(0, 2)}/${value.substring(2, 4)}/${value.substring(4)}';
    }
    return value;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dtBirthday,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (picked != null && picked != dtBirthday) {
      setState(() {
        dtBirthday = picked;
      });
    }
  }
}
