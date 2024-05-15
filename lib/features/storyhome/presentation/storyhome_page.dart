import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storyhome/model/topic_button_object.dart';
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_cubit.dart';
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_state.dart';
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_page.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

@RoutePage()
class StoryHomePage extends StatefulWidget {
  const StoryHomePage({super.key, required this.onPageChanged});

  final Function(int) onPageChanged;

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryHomeState, StoryHomeCubit, StoryHomePage> {
  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildByState(BuildContext context, StoryHomeState state) {
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
                leading: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CustomBackButton()]),
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
                    recommendedList(),
                    Container(height: 24),
                    topicList(),
                    SizedBox(height: cubit.HEIGHT * 0.05),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
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

  Widget listTopicButton(List<TopicButtonObject> list) {
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

  Widget topicButton(TopicButtonObject btnObject) {
    return GestureDetector(
        onTap: () async {
          loadingController.showLoading();
          await _setCurrentStoryTopic(btnObject.id);
          context.router.pushNamed(Routes.storytopic);
          loadingController.hideLoading();
        },
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
              buttonImage(btnObject.imageUrl),
              Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: buttonTitle(btnObject.title)),
            ])));
  }

  Widget storyButton(StoryButtonObject btnObject) {
    return GestureDetector(
        onTap: () async {
          await storyController.getStory(context, id: btnObject.id!);
          await userStoryController.createOrGetUserStory(context,
              userId: controller.currentUser.value.id, storyId: btnObject.id!);
          await _navigateToOverviewPage();
        },
        child: Container(
            width: cubit.WIDTH * 0.37,
            height: cubit.WIDTH * 0.37,
            margin: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
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
              buttonImage(btnObject.avatar),
              Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: buttonTitle(btnObject.name)),
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
      child: Image.network(url, fit: BoxFit.cover),
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
      const SizedBox(height: 15),
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
          height: cubit.WIDTH * 0.45,
          width: cubit.WIDTH,
          child: listRecommendedButton(cubit.lstRecommend))
    ]);
  }

  Widget topicList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: cubit.WIDTH,
          child: const Text("Topics",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500))),
      const SizedBox(height: 10),
      listTopicButton(cubit.lstTopic)
    ]);
  }

  Widget listRecommendedButton(List<StoryButtonObject> list) {
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

  Future<void> _onSearch(String? value) async {
    FocusScope.of(context).unfocus();
    await storyController.updateSearching(context, text: value ?? "");
    widget.onPageChanged(2);
  }

  Future<void> _navigateToOverviewPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              StoryOverviewPage(onClosed: (String value) async {})),
    );
  }

  _getAllStoryTopics(BuildContext context) async {
    await storyTopicController.getAllStoryTopics(context);

    setState(() {
      // print(storyTopicController.listStoryTopic.value.length);
      cubit.getAllTopics(storyTopicController.listStoryTopic.value);
    });
  }

  _getStoriesByReleaseDate(BuildContext context) async {
    await storyController.getStoriesByReleaseDate(context, true);

    setState(() {
      // print(storyTopicController.listStoryTopic.value.length);
      cubit.getRecommendStories(storyController.listStory.value.sublist(0, 5));
    });
  }

  _setCurrentStoryTopic(String id) async {
    await storyTopicController.updateCurrentStoryTopic(context, id);
  }

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
    _setDimension();
    controller.getCurrentUser(context);
    _getAllStoryTopics(context);
    _getStoriesByReleaseDate(context);
    // print(storyTopicController.listStoryTopic.value.length);
  }
}
