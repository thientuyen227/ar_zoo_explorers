import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_cubit.dart';
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_state.dart';
import 'package:ar_zoo_explorers/features/base-model/FormBuilderTextField_Model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../utils/widget/button_widget.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<UserProfileState, UserProfileCubit, UserProfilePage> {
  final TextEditingController dateController = TextEditingController();
  List<String> listGender = ['Nam', 'Nữ'];
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 1);
  String txtFullName = "";
  String txtEmail = "";
  String txtPhoneNumber = "";
  String txtGender = "Nam";
  DateTime dtBirthday = DateTime.now();
  String txtAddress = "";
  bool isApproved = false;

  @override
  Widget buildByState(BuildContext context, UserProfileState state) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: SizedBox(
                width: double.infinity,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Transform.scale(
                      scale: 1.5,
                      child: Image.asset(AppImages.imgAppLogo, height: 45)),
                  const SizedBox(width: 15),
                  const Text('Trang cá nhân',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ])),
            actions: const [SizedBox(width: 55)],
            leading: AppIconButton(
                onPressed: () {
                  context.router.pushNamed(Routes.home);
                },
                icon: Transform.scale(
                    scale: 1.5,
                    child: Image.asset(AppIcons.icBack_png, height: 55)))),
        body: SingleChildScrollView(
            child: Column(children: [
          ProfileHeader(),
          Container(
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
                SelectGender(),
                const SizedBox(height: 25),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SubmitButton(context)]),
                const SizedBox(height: 25),
              ]))
        ])));
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

  Widget SubmitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          _showDialog(context);
        },
        style: TextButton.styleFrom(
            minimumSize: const Size(180, 50),
            backgroundColor: Colors.green, // Màu nền
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10), // Khoảng cách giữa chữ và nút
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30) // Đổ viền cho nút
                )),
        child: Row(children: [
          const Text("Thay đổi thông tin",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(width: 5),
          SizedBox(height: 24, child: Image.asset(AppIcons.icWhiteSubmit))
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

  Widget TitlePage() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(15.0)),
        child: const Center(
            child: Text("Thông tin cá nhân",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blue,
                    fontFamily: 'Times New Roman'))));
  }

  Widget ProfileHeader() {
    return Stack(children: [
      SizedBox(width: MediaQuery.of(context).size.width, height: 150),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ClipRect(
              child: Image.asset(AppImages.imgAppLogoBG, fit: BoxFit.cover))),
      Positioned(
          bottom: 0,
          left: 30,
          child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRect(
                  child: Image.asset(AppImages.imgDefaultUser,
                      fit: BoxFit.cover)))),
    ]);
  }

  Widget SelectGender() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        SizedBox(width: 20),
        Text("Giới tính",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 5),
      CupertinoPicker(
          itemExtent: 50.0,
          scrollController: scrollController,
          onSelectedItemChanged: (int index) {
            setState(() {
              txtGender = listGender[index];
            });
          },
          children: listGender.map((String option) {
            return Center(
                child: Text(option, style: const TextStyle(fontSize: 20)));
          }).toList())
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

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:
                  const Text('Xác nhận thay đổi', textAlign: TextAlign.center),
              content: const Text('Bạn đã chắc chắn với thông tin cập nhật?'),
              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          child: const Text('Không'),
                          onPressed: () {
                            context.router.pushNamed(Routes.home);
                          }),
                      TextButton(
                          child: const Text('Có'),
                          onPressed: () {
                            context.router.pushNamed(Routes.userprofile);
                          })
                    ])
              ]);
        });
  }

  // void _TurnPage() {
  //   Navigator.of(context).push(PageRouteBuilder(
  //       opaque: false,
  //       pageBuilder: (BuildContext context, _, __) {
  //         return const AnimatedOpacity(
  //             duration: Duration(milliseconds: 500),
  //             opacity: 1.0,
  //             child: HomePage());
  //       }));
  // }
}
