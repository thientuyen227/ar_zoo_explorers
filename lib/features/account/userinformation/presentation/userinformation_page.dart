import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/model/provincial_name.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_cubit.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
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

  @override
  Widget buildByState(BuildContext context, UserInformationState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
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
                          RadioForm("Giới tính"),
                          TextForm("Số điện thoại", 2,
                              controller.currentUser.value.phone),
                          DropdownForm("Tỉnh / Thành phố"),
                          TextForm("Địa chỉ", 3, cubit.address)
                        ])),
                    const Divider(),
                    FutureBuilder(
                        future: controller.getCurrentUser(context),
                        builder: (context, snapshot) =>
                            Align(child: SubmitButton(context, snapshot))),
                    const SizedBox(height: 20),
                  ]))),
            ))));
  }

  Widget TextForm(String title, int index, String? content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleForm(title),
      const SizedBox(height: 10),
      BodyForm(index, content),
      const SizedBox(height: 12)
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

  Widget DropdownForm(String title) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleForm(title),
      const SizedBox(height: 10),
      FormBuilderTypeAhead(
          name: 'provincial',
          decoration: InputDecoration(
              hintText: 'Select Provincial',
              prefixIcon:
                  Image.asset(AppIcons.icProvincial, height: 20, width: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(10)),
          itemBuilder: (context, suggestion) {
            return ListTile(title: Text(suggestion));
          },
          controller: TextEditingController(),
          suggestionsCallback: (pattern) async {
            return Provincial()
                .names
                .where((city) =>
                    city.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Không thể để trống"),
            (value) {
              if (value != null && !Provincial().names.contains(value)) {
                return 'Tỉnh/Thành phố không đúng!';
              }
              return null;
            }
          ])),
      const SizedBox(height: 12)
    ]);
  }

  Widget ProfileHeader() {
    return Stack(children: [
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.21),
      BackGround(),
      Positioned(
          left: 0, right: 0, bottom: 0, child: Center(child: UserAvatar())),
    ]);
  }

  Widget BackGround() {
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
    );
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.16,
        decoration: BoxDecoration(
            border: Border.all(width: 0), borderRadius: borderRadius),
        child: ClipRRect(
            borderRadius: borderRadius,
            child: (cubit.userBackground == "")
                ? Image.asset(AppImages.imgAppLogoBG, fit: BoxFit.cover)
                : Image.network(cubit.userBackground, fit: BoxFit.cover)));
  }

  Widget UserAvatar() {
    return Container(
        width: MediaQuery.of(context).size.height * 0.155,
        height: MediaQuery.of(context).size.height * 0.155,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 5),
            shape: BoxShape.circle),
        child: ClipOval(
          child: (cubit.userAvatar == "")
              ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
              : Image.network(cubit.userAvatar, fit: BoxFit.cover),
        ));
  }

  Widget TurnBack() {
    return AppIconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: Transform.scale(
            scale: 1.5, child: Image.asset(AppIcons.icBack_png, height: 55)));
  }

  Widget SubmitButton(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return TextButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? () => _onUpdatePressed(context)
            : () => {
                  Fluttertoast.showToast(msg: "Đang cập nhật!"),
                  _onUpdatePressed(context)
                },
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
          readOnly: true,
          controller: TextEditingController(
              text: DateFormat('dd/MM/yyyy').format(cubit.dtBirthday)),
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Chọn ngày tháng',
              prefixIcon: Image.asset(AppIcons.icCalendar),
              contentPadding: const EdgeInsets.all(10))),
      const SizedBox(height: 12),
    ]);
  }

  Widget RadioForm(String title) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleForm(title),
      const SizedBox(height: 10),
      FormBuilderRadioGroup(
          name: 'gender',
          wrapAlignment: WrapAlignment.spaceEvenly,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(2)),
          options: const [
            FormBuilderFieldOption(
                value: 'male',
                child: Text('Nam', style: TextStyle(fontSize: 17))),
            FormBuilderFieldOption(
                value: 'female',
                child: Text('Nữ', style: TextStyle(fontSize: 17))),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Bạn chưa chọn giới tính")
          ])),
      const SizedBox(height: 12),
    ]);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: cubit.dtBirthday,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != cubit.dtBirthday) {
      setState(() {
        cubit.dtBirthday = picked;
      });
    }
  }

  String _getAddress() {
    return _formKey.currentState!.fields['address']!.value +
        ", " +
        _formKey.currentState!.fields['provincial']!.value;
  }

  Future<void> _onUpdatePressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // ignore: use_build_context_synchronously
      await controller.updateUserProfile(context,
          id: controller.currentUser.value.id,
          fullname: _formKey.currentState!.fields['fullname']!.value,
          phone: _formKey.currentState!.fields['phone']!.value,
          avatarUrl: cubit.userAvatar,
          address: _getAddress(),
          birth: cubit.getBirthday(),
          provider: cubit.provider);
      context.router.popAndPush(const UserProfileRoute());
    }
  }

  void setValueAddress(String address) {
    cubit.setAddress(address);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.patchValue({'provincial': cubit.provincial});
    });
  }

  @override
  void initState() {
    super.initState();
    cubit.setBirthday(controller.currentUser.value.birth);
    cubit.setUserAvatar(controller.currentUser.value.avatarUrl);
    cubit.setProvider(controller.currentUser.value.provider);
    setValueAddress(controller.currentUser.value.address);
  }
}
