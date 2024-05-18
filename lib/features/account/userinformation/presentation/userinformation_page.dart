import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
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
import 'package:internationalization/internationalization.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';
import '../../../../core/data/controller/auth_controller.dart';

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
  final ImagePicker _picker = ImagePicker();

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
                          textForm(LanguageKeys.fullname.tr, 0,
                              controller.currentUser.value.fullname),
                          textForm(LanguageKeys.emailAddress.tr, 1,
                              controller.currentUser.value.email),
                          dateForm(),
                          radioForm(LanguageKeys.gender.tr),
                          textForm(LanguageKeys.phone.tr, 2,
                              controller.currentUser.value.phone),
                          dropdownForm(
                              "${LanguageKeys.province.tr} / ${LanguageKeys.city.tr}"),
                          textForm(LanguageKeys.address.tr, 3, cubit.address)
                        ])),
                    const Divider(),
                    FutureBuilder(
                        future: controller.getCurrentUser(context),
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
      name: cubit.ListFormItem[index].name,
      initialValue: content,
      enabled: (cubit.ListFormItem[index].name == 'email') ? false : true,
      decoration: InputDecoration(
          hintText: cubit.ListFormItem[index].hint_text,
          prefixIcon: Image.asset(cubit.ListFormItem[index].icon_prefix,
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
              //return null;
            }
          ])),
      const SizedBox(height: 12)
    ]);
  }

  Widget profileHeader() {
    return Stack(children: [
      SizedBox(width: cubit.WIDTH, height: cubit.HEIGHT * 0.3),
      profileBackground(),
      Positioned(
          left: 0,
          right: 0,
          bottom: cubit.HEIGHT * 0.04,
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
          gradientBackground(cubit.HEIGHT * 0.13, cubit.WIDTH, 0,
              Colors.blue.shade800, Colors.blue.shade200),
          gradientBackground(cubit.HEIGHT * 0.07, cubit.WIDTH, 5,
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
      SizedBox(width: cubit.HEIGHT * 0.155, height: cubit.HEIGHT * 0.155),
      Container(
          width: cubit.HEIGHT * 0.155,
          height: cubit.HEIGHT * 0.155,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
              shape: BoxShape.circle),
          child: ClipOval(
            child: (cubit.userAvatar == "")
                ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
                : Image.network(cubit.userAvatar, fit: BoxFit.cover),
          )),
      updateAvatarButton()
    ]);
  }

  Widget submitButton(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return TextButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? () => _onUpdatePressed(context)
            : () => {
                  Fluttertoast.showToast(msg: "${LanguageKeys.updating.tr}!"),
                  _onUpdatePressed(context)
                },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(140, 43)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: Text(LanguageKeys.update.tr,
            style: const TextStyle(fontSize: 16, color: Colors.white)));
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
              text: DateFormat('dd/MM/yyyy').format(cubit.dtBirthday)),
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
          initialValue: cubit.gender,
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
              await _uploadInformation(context);
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                  width: cubit.WIDTH * 0.1,
                  height: cubit.WIDTH * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle)),
              ClipRect(
                  child: Image.asset(AppIcons.icCamera,
                      width: cubit.WIDTH * 0.08, fit: BoxFit.cover))
            ])));
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
      await _uploadInformation(context);
      context.router.popAndPush(const UserProfileRoute());
    }
  }

  Future<void> _uploadInformation(BuildContext context) async {
    await controller.updateUserProfile(context,
        id: controller.currentUser.value.id,
        fullname: _formKey.currentState!.fields['fullname']!.value,
        phone: _formKey.currentState!.fields['phone']!.value,
        avatarUrl: cubit.userAvatar,
        address: _getAddress(),
        birth: cubit.getBirthday(),
        provider: cubit.provider,
        gender: _formKey.currentState!.fields['gender']!.value,
        role: controller.currentUser.value.role,
        status: controller.currentUser.value.status);
  }

  void setValueAddress(String address) {
    cubit.setAddress(address);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.patchValue({'provincial': cubit.provincial});
    });
  }

  Future<void> updateAvatar(BuildContext context) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String imageName = cubit.avatarName(controller.currentUser.value.fullname);
    String? downloadURL =
        // ignore: use_build_context_synchronously
        await controller.uploadAvatar(context, image!.path, imageName);
    setState(() {
      cubit.userAvatar = downloadURL;
    });
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

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.WIDTH = MediaQuery.of(context).size.width;
      cubit.HEIGHT = MediaQuery.of(context).size.height;
    });
  }

  @override
  void initState() {
    super.initState();
    setDimension();

    cubit.setBirthday(controller.currentUser.value.birth);
    cubit.setUserAvatar(controller.currentUser.value.avatarUrl);
    cubit.setProvider(controller.currentUser.value.provider);
    cubit.setGender(controller.currentUser.value.gender);
    setValueAddress(controller.currentUser.value.address);
  }
}
