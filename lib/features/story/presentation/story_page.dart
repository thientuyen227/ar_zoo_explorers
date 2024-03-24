import 'package:ar_zoo_explorers/features/story/presentation/story_cubit.dart';
import 'package:ar_zoo_explorers/features/story/presentation/story_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../app/config/routes.dart';
import '../../../app/theme/dimens.dart';
import '../../../app/theme/icons.dart';
import '../../../base/base_state.dart';
import '../../../base/widgets/page_loading_indicator.dart';
import '../../../core/data/controller/auth_controller.dart';
import '../../../utils/widget/button_widget.dart';
import '../../base-model/button_object.dart';
import '../../base-model/form_builder_text_field_model.dart';

@RoutePage()
class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryState, StoryCubit, StoryPage> {
  final controller = AuthController.findOrInitialize;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildByState(BuildContext context, StoryState state) {
    return Obx(
      () => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
          future: null,
          scaffold: Scaffold(
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
                centerTitle: true,
                title: const Text("Story Home",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                backgroundColor: const Color.fromARGB(255, 109, 189, 255),
                // backgroundColor: Colors.white,
                elevation: 1,
                leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [backButton()]),
                actions: [profileCustom(), const SizedBox(width: 15)]),
            body: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 50),
                  child: Column(children: [
                    Container(height: 24),
                    searchBar(cubit.searchBar),
                    Container(height: 24),
                    recommendedList(),
                    Container(height: 24),
                    topicList(),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget backButton() {
    return AppIconButton(
      onPressed: () => context.router.pop(),
      icon: Container(
          margin: const EdgeInsets.only(left: 0),
          child: Transform.scale(
              scale: 1.15,
              child:
                  Image.asset(AppIcons.icBack_x64_png, height: 24, width: 24))),
    );
  }

  Widget profileCustom() {
    return AppIconButton(
        onPressed: () {
          context.router.pushNamed(Routes.userprofile);
        },
        icon: Row(children: [
          Text(cubit.nameCustom(controller.currentUser.value.fullname, 8),
              style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 5),
          userImage()
        ]));
  }

  Widget userImage() {
    return ClipOval(
        child: (controller.currentUser.value.avatarUrl == "")
            ? Image.asset(AppImages.imgProfile128x128,
                fit: BoxFit.cover,
                width: AppDimens.size30.width,
                height: AppDimens.size30.height)
            : Image.network(controller.currentUser.value.avatarUrl,
                fit: BoxFit.cover,
                width: AppDimens.size30.width,
                height: AppDimens.size30.height));
  }

  // THANH TÌM KIẾM
  Widget searchBar(FormBuilderTextFieldModel item) {
    return FormBuilderTextField(
        name: item.name,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            hintText: item.hint_text,
            suffixIcon: IconButton(
                onPressed: () async {
                  await _onSearch(
                      _formKey.currentState!.fields['search']?.value);
                },
                icon: Image.asset(item.icon_suffix)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25)),
        style: const TextStyle(fontSize: 16),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([]));
  }

  Widget listTopicButton(List<ButtonObject> list) {
    List<Widget> listRow = [];
    for (int i = 0; i < list.length - 1; i = i + 2) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [topicButton(list[i]), topicButton(list[i + 1])]));
      listRow.add(const SizedBox(height: 20));
    }
    if ((list.length) % 2 != 0) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topicButton(list[list.length - 1]),
            const SizedBox(height: 150, width: 150)
          ]));
      listRow.add(const SizedBox(height: 20));
    }
    return Column(children: listRow);
  }

  Widget topicButton(ButtonObject btnObject) {
    return GestureDetector(
        onTap: () async => {},
        child: Container(
            width: cubit.WIDTH * 0.39,
            height: cubit.WIDTH * 0.39,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            child: Column(children: [
              buttonImage(btnObject.icon),
              Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: buttonTitle(btnObject.title)),
            ])));
  }

  Widget storyButton(ButtonObject btnObject) {
    return GestureDetector(
        onTap: () async => {},
        child: Container(
            width: cubit.WIDTH * 0.37,
            height: cubit.WIDTH * 0.37,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 1))
                ]),
            child: Column(children: [
              buttonImage(btnObject.icon),
              Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: buttonTitle(btnObject.title)),
            ])));
  }

  Widget buttonImage(String url) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: cubit.WIDTH,
      height: cubit.WIDTH * 0.25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.white),
      // child: (url == "")
      //     ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
      //     : Image.network(url, fit: BoxFit.cover),
      child: Image.asset(url, fit: BoxFit.cover),
    );
  }

  // TÊN MODEL
  Widget buttonTitle(String title) {
    return SizedBox(
        width: cubit.WIDTH * 0.28,
        child: Text(cubit.customContent(title, 30),
            style: const TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
            softWrap: true,
            textAlign: TextAlign.center));
  }

  Widget recommendedList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Recommended",
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500)),
        Text("View",
            style: TextStyle(
                color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w500)),
      ]),
      const SizedBox(height: 10),
      SizedBox(
          height: cubit.WIDTH * 0.39,
          width: cubit.WIDTH,
          child: listRecommendedButton(cubit.lstRecommend))
    ]);
  }

  Widget topicList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Topics",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500)),
      const SizedBox(height: 10),
      listTopicButton(cubit.lstTopic)
    ]);
  }

  Widget listRecommendedButton(List<ButtonObject> list) {
    if (list.isEmpty) {
      return const Text("Chưa cập nhật!");
    }
    List<Widget> listRow = [];
    for (int i = 0; i < list.length; i = i + 1) {
      listRow.add(storyButton(list[i]));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Row(children: listRow));
  }

  Future<void> _onSearch(String? value) async {}

  void _setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.WIDTH = MediaQuery.of(context).size.width;
        cubit.HEIGHT = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    controller.getCurrentUser(context);
    _setDimension();
  }
}
