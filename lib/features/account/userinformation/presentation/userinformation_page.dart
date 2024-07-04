import 'dart:io';

import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/model/provincial_name.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_cubit.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';

@RoutePage()
class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<UserInformationState, UserInformationCubit,
    UserInformationPage> {
  @override
  void initState() {
    cubit.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _formKey.currentState?.patchValue({'provincial': state.provincial});
        _formKey.currentState?.patchValue({'address': state.address});
        usernameController.text = cubit.controller.currentUser.value.fullname;
      });
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  TextEditingController usernameController = TextEditingController();
  File? _selectedImage;

  @override
  Widget buildByState(BuildContext context, UserInformationState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: Text(LanguageKeys.updateInformation.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  actions: const [],
                  leading: const CustomBackButton()),
              body: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    profileHeader(),
                    Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(children: [
                          // textForm(LanguageKeys.fullname.tr, 0,
                          //     cubit.controller.currentUser.value.fullname),
                          usernameForm(),
                          textForm(LanguageKeys.emailAddress.tr, 1,
                              cubit.controller.currentUser.value.email),
                          dateForm(),
                          radioForm(LanguageKeys.gender.tr),
                          textForm(LanguageKeys.phone.tr, 2,
                              cubit.controller.currentUser.value.phone),
                          dropdownForm(
                              "${LanguageKeys.province.tr} / ${LanguageKeys.city.tr}"),
                          textForm(LanguageKeys.address.tr, 3, state.address)
                        ])),
                    const SizedBox(height: 20),
                    FutureBuilder(
                        future: cubit.controller.getCurrentUser(context),
                        builder: (context, snapshot) =>
                            Align(child: submitButton(context, snapshot))),
                    const SizedBox(height: 40),
                  ]))),
            ))));
  }

  Widget textForm(String title, int index, String? content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      titleForm(title),
      const SizedBox(height: 10),
      bodyForm(index, content),
      const SizedBox(height: 12)
    ]);
  }

  Widget titleForm(String title) {
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

  Widget bodyForm(int index, String? content) {
    return FormBuilderTextField(
      name: state.ListFormItem[index].name,
      initialValue: content,
      enabled: (state.ListFormItem[index].name == 'email') ? false : true,
      decoration: InputDecoration(
          hintText: state.ListFormItem[index].hint_text,
          prefixIcon: Image.asset(state.ListFormItem[index].icon_prefix,
              height: 20, width: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(10)),
      inputFormatters: (index == 2)
          ? [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
            errorText: LanguageKeys.requiredField.tr),
        (value) {
          return _onHandleValidator(index, value);
        }
      ]),
    );
  }

  Widget usernameForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      titleForm(LanguageKeys.fullname.tr),
      const SizedBox(height: 10),
      TextFormField(
        controller: usernameController,
        // initialValue: cubit.controller.currentUser.value.fullname,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: state.ListFormItem[0].hint_text,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Image.asset(state.ListFormItem[0].icon_prefix,
              height: 20, width: 20),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: LanguageKeys.requiredField.tr),
          (value) {
            return _onHandleValidator(0, value);
          }
        ]),
      ),
      const SizedBox(height: 12)
    ]);
  }

  Widget dropdownForm(String title) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      titleForm(title),
      const SizedBox(height: 10),
      FormBuilderTypeAhead(
          name: 'provincial',
          decoration: InputDecoration(
              hintText: LanguageKeys.selectProvincial.tr,
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
            FormBuilderValidators.required(
                errorText: LanguageKeys.requiredField.tr),
            (value) {
              if (value != null && !Provincial().names.contains(value)) {
                return '${LanguageKeys.msg_invalidProvinceCity.tr}!';
              }
              return null;
            }
          ])),
      const SizedBox(height: 12)
    ]);
  }

  Widget profileHeader() {
    return Stack(children: [
      SizedBox(width: state.width, height: state.height * 0.3),
      profileBackground(),
      Positioned(
          left: 0,
          right: 0,
          bottom: state.height * 0.04,
          child: Center(child: userAvatar())),
    ]);
  }

  Widget profileBackground() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0))),
        child: Column(children: [
          gradientBackground(state.height * 0.13, state.width, 0,
              AppColor.appBarColor, Colors.blue.shade200),
          gradientBackground(state.height * 0.07, state.width, 5,
              Colors.blue.shade200, Colors.blue.shade800)
        ]));
  }

  Widget gradientBackground(double height, double width, double borderRadius,
      Color topColor, Color bottomColor) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius)),
            gradient: LinearGradient(
                colors: [topColor, bottomColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
            // image: const DecorationImage(
            //     image: AssetImage(AppImages.imgAppLogoBG), fit: BoxFit.cover),
            ));
  }

  Widget userAvatar() {
    return Stack(children: [
      SizedBox(width: state.height * 0.155, height: state.height * 0.155),
      Container(
          width: state.height * 0.155,
          height: state.height * 0.155,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
              shape: BoxShape.circle),
          child: ClipOval(
            child: (state.userAvatar == "")
                ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
                : Image.network(state.userAvatar, fit: BoxFit.cover),
          )),
      updateAvatarButton()
    ]);
  }

  Widget submitButton(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return GestureDetector(
        onTap: () async => {await _onUpdatePressed(context)},
        child: Container(
          padding: EdgeInsets.fromLTRB(
            state.width * 0.055,
            state.width * 0.025,
            state.width * 0.055,
            state.width * 0.025,
          ),
          decoration: BoxDecoration(
              color: AppColor.activeBlue,
              borderRadius: BorderRadius.circular(state.width * 0.07),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3)),
              ]),
          child: Text(LanguageKeys.update.tr,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ));
  }

  Widget dateForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      titleForm(LanguageKeys.birthday.tr),
      const SizedBox(height: 10),
      TextFormField(
          onTap: () {
            _selectDate(context);
          },
          readOnly: true,
          controller: TextEditingController(
              text: DateFormat('dd/MM/yyyy').format(state.dtBirthday)),
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: LanguageKeys.selectDate.tr,
              prefixIcon: Image.asset(AppIcons.icCalendar),
              contentPadding: const EdgeInsets.all(10))),
      const SizedBox(height: 12),
    ]);
  }

  Widget radioForm(String title) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      titleForm(title),
      const SizedBox(height: 10),
      FormBuilderRadioGroup(
          name: 'gender',
          wrapAlignment: WrapAlignment.spaceEvenly,
          initialValue: state.gender,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(2)),
          options: [
            FormBuilderFieldOption(
                value: 'male',
                child: Text(LanguageKeys.male.tr,
                    style: const TextStyle(fontSize: 17))),
            FormBuilderFieldOption(
                value: 'female',
                child: Text(LanguageKeys.female.tr,
                    style: const TextStyle(fontSize: 17))),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: LanguageKeys.msg_notSelectedAGender.tr)
          ])),
      const SizedBox(height: 12),
    ]);
  }

  Widget updateAvatarButton() {
    return Positioned(
        bottom: 0,
        right: 0,
        child: GestureDetector(
            onTap: () async {
              await updateAvatar(context);
              // await _uploadInformation(context);
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                  width: state.width * 0.1,
                  height: state.width * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle)),
              ClipRect(
                  child: Image.asset(AppIcons.icCamera,
                      width: state.width * 0.08, fit: BoxFit.cover))
            ])));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: state.dtBirthday,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != state.dtBirthday) {
      setState(() {
        cubit.changeDtBirthday(picked);
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
      cubit.showLoading();
      Fluttertoast.showToast(msg: "${LanguageKeys.updating.tr}!");
      // ignore: use_build_context_synchronously
      await _uploadInformation(context);
      context.router.popAndPush(const UserProfileRoute());
      cubit.hideLoading();
    }
  }

  Future<void> _uploadInformation(BuildContext context) async {
    await cubit.controller.updateUserProfile(context,
        id: cubit.controller.currentUser.value.id,
        fullname: usernameController.value.text,
        phone: _formKey.currentState!.fields['phone']!.value,
        avatarUrl: state.userAvatar,
        address: _getAddress(),
        birth: cubit.getBirthday(),
        provider: state.provider,
        gender: _formKey.currentState!.fields['gender']!.value,
        role: cubit.controller.currentUser.value.role,
        status: cubit.controller.currentUser.value.status);
    // print(usernameController.value.text);
  }

  Future<void> _updateAvatar(BuildContext context, String url) async {
    await cubit.controller.updateUserAvatar(
      context,
      id: cubit.controller.currentUser.value.id,
      avatarUrl: url,
    );
  }

  Future<void> updateAvatar(BuildContext context) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String imageName =
        cubit.avatarName(cubit.controller.currentUser.value.fullname);
    if (image != null) {
      cubit.showLoading();
      String? downloadURL =
          // ignore: use_build_context_synchronously
          await cubit.controller.uploadAvatar(context, image.path, imageName);
      await _updateAvatar(context, downloadURL);
      setState(() {
        state.userAvatar = downloadURL;
      });
      cubit.hideLoading();
    } else {
      cubit.hideLoading();
      await cubit.showToast(LanguageKeys.get_img_failed.tr);
    }
  }

  String? _onHandleValidator(int index, String? value) {
    switch (index) {
      case 0:
        return cubit.onCheckFullname(value);
      case 2:
        return cubit.onCheckPhoneNumber(value);
      default:
        return null;
    }
  }
}
