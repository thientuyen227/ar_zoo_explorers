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
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();

  @override
  Widget buildByState(BuildContext context, UserInformationState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Edit Information',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  actions: const [],
                  leading: turnBack()),
              body: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    profileHeader(),
                    Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(children: [
                          textForm("Full Name", 0,
                              controller.currentUser.value.fullname),
                          textForm("Email Address", 1,
                              controller.currentUser.value.email),
                          dateForm(),
                          radioForm("Gender"),
                          textForm("Phone Number", 2,
                              controller.currentUser.value.phone),
                          dropdownForm("Province / City"),
                          textForm("Address", 3, cubit.address)
                        ])),
                    const Divider(),
                    FutureBuilder(
                        future: controller.getCurrentUser(context),
                        builder: (context, snapshot) =>
                            Align(child: submitButton(context, snapshot))),
                    const SizedBox(height: 20),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Required field"),
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
            FormBuilderValidators.required(errorText: "Required field"),
            (value) {
              if (value != null && !Provincial().names.contains(value)) {
                return 'Invalid Province/City!';
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
      SizedBox(width: cubit.WIDTH, height: cubit.HEIGHT * 0.21),
      backGround(),
      Positioned(
          left: 0, right: 0, bottom: 0, child: Center(child: userAvatar())),
    ]);
  }

  Widget backGround() {
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
    );
    return Container(
        width: cubit.WIDTH,
        height: cubit.HEIGHT * 0.16,
        decoration: BoxDecoration(
            border: Border.all(width: 0), borderRadius: borderRadius),
        child: ClipRRect(
            borderRadius: borderRadius,
            child: (cubit.userBackground == "")
                ? Image.asset(AppImages.imgAppLogoBG, fit: BoxFit.cover)
                : Image.network(cubit.userBackground, fit: BoxFit.cover)));
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

  Widget turnBack() {
    return AppIconButton(
        onPressed: () => context.router.popAndPush(const UserProfileRoute()),
        icon: Transform.scale(
            scale: 1.5, child: Image.asset(AppIcons.icBack_png, height: 55)));
  }

  Widget submitButton(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return TextButton(
        onPressed: snapshot.connectionState != ConnectionState.waiting
            ? () => _onUpdatePressed(context)
            : () => {
                  Fluttertoast.showToast(msg: "Updating!"),
                  _onUpdatePressed(context)
                },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(140, 43)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: const Text("Update",
            style: TextStyle(fontSize: 16, color: Colors.white)));
  }

  Widget dateForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      titleForm("Birthday"),
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
              hintText: 'Select Date',
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
          options: const [
            FormBuilderFieldOption(
                value: 'male',
                child: Text('Male', style: TextStyle(fontSize: 17))),
            FormBuilderFieldOption(
                value: 'female',
                child: Text('Female', style: TextStyle(fontSize: 17))),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "You have not selected a gender.")
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
