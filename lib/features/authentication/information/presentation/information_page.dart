import 'package:ar_zoo_explorers/features/authentication/information/presentation/information_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/information/presentation/information_state.dart';
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_page.dart';
import 'package:ar_zoo_explorers/features/base-model/FormBuilderTextField_Model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';

@RoutePage()
class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<InformationState, InformationCubit, InformationPage> {
  final TextEditingController dateController = TextEditingController();
  String txtFullName = "";
  String txtEmail = "";
  String txtPhoneNumber = "";
  DateTime dtBirthday = DateTime.now();
  String txtAddress = "";
  bool isApproved = false;

  @override
  Widget buildByState(BuildContext context, InformationState state) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Transform.scale(
                scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                child: Image.asset(AppImages.imgAppLogo, height: 55)),
            leading: ElevatedButton(
                onPressed: () {
                  context.router.pushNamed(Routes.login);
                },
                child: Image.asset(AppIcons.icBack_png, height: 40))),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: Column(children: [
                  const SizedBox(height: 25),
                  TitlePage(),
                  const SizedBox(height: 20),
                  fbtfTextNormal(
                      "Họ và tên*",
                      FormBuilderTextFieldModel(
                          name: "FullName",
                          txtValue: txtFullName,
                          hint_text: "Họ và tên đầy đủ",
                          icon_prefix: AppIcons.icUser,
                          isObscured: false,
                          TIT: TextInputType.text)),
                  const SizedBox(height: 15),
                  fbtfTextNormal(
                      "Số điện thoại*",
                      FormBuilderTextFieldModel(
                          name: "PhoneNumber",
                          txtValue: txtPhoneNumber,
                          hint_text: "Số điện thoại",
                          icon_prefix: AppIcons.icPhone,
                          isObscured: false,
                          TIT: TextInputType.phone)),
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
                  fbtfTextNormal(
                      "Địa chỉ*",
                      FormBuilderTextFieldModel(
                          name: "Address",
                          txtValue: txtAddress,
                          hint_text: "Địa chỉ",
                          icon_prefix: AppIcons.icAddress,
                          isObscured: false,
                          TIT: TextInputType.text)),
                  const SizedBox(height: 15),
                  SelectBirthday(),
                  const SizedBox(height: 15),
                  AcceptWithRules(),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [BackButton(), SubmitButton()])
                ]))));
  }

  Widget fbtfTextNormal(String title, FormBuilderTextFieldModel items,
      {BuildContext? context}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const SizedBox(width: 20),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold))
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

  Widget BackButton() {
    return ElevatedButton(
        onPressed: () {
          context.router.pushNamed(Routes.register);
        },
        style: TextButton.styleFrom(
            minimumSize: const Size(160, 50),
            backgroundColor: Colors.blue, // Màu nền
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10), // Khoảng cách giữa chữ và nút
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30) // Đổ viền cho nút
                )),
        child: Row(children: [
          SizedBox(height: 24, child: Image.asset(AppIcons.icBack_png)),
          const SizedBox(width: 5),
          const Text("Quay lại",
              style: TextStyle(fontSize: 20, color: Colors.white))
        ]));
  }

  Widget SubmitButton() {
    return ElevatedButton(
        onPressed: () {
          context.router.pushNamed(Routes.information);
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
          const Text("Đăng ký",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(width: 5),
          SizedBox(height: 24, child: Image.asset(AppIcons.icNext_png))
        ]));
  }

  Widget SelectBirthday() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 20),
        Text("Ngày sinh",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 5),
      TextFormField(
          readOnly: true, // Đánh dấu ô nhập liệu là chỉ đọc
          controller: TextEditingController(
              text: DateFormat('dd/MM/yyyy')
                  .format(dtBirthday)), // Định dạng hiển thị
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Chọn ngày tháng',
              prefixIcon: IconButton(
                  icon: Image.asset(AppIcons.icCalendar),
                  onPressed: () async {
                    _selectDate(context);
                  }),
              contentPadding: const EdgeInsets.all(10)))
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
      InkWell(
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

  Widget TitlePage() {
    return Container(
        width:
            MediaQuery.of(context).size.width * 0.8, // Chiều ngang 80% màn hình
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền của Container
          border: Border.all(
              color: Colors.grey, // Màu viền
              width: 1.5 // Độ dày của viền
              ),
          borderRadius:
              BorderRadius.circular(15.0), // Độ cong góc của Container
        ),
        child: const Center(
          child: Text("Thông tin cá nhân",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blue,
                  fontFamily: 'Times New Roman')),
        ));
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

  void _TurnPage() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return const AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: 1.0, // Độ mờ 80%
              child: TermOfServicePage());
        }));
  }
}
