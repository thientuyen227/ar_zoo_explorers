import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/base/widgets/page_loading_indicator.dart';
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
import 'package:get/get.dart';

@RoutePage()
class StoryHomePage extends StatefulWidget {
  const StoryHomePage(
      {super.key,
      required this.onPageChanged,
      required this.toggleBottomBarVisibility});

  final Function(int) onPageChanged;
  final VoidCallback toggleBottomBarVisibility;

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryHomeState, StoryHomeCubit, StoryHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildByState(BuildContext context, StoryHomeState state) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
              // extendBodyBehindAppBar: true,
              appBar: AppBar(
                  centerTitle: true,
                  title: Text(LanguageKeys.explore.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold)),
                  backgroundColor: AppColor.appBarColor,
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
                      searchBar(state.searchBar),
                      recommendedList(),
                      Container(height: 24),
                      topicList(),
                      SizedBox(height: state.height * 0.05),
                    ]),
                  ),
                ),
              ),
            )));
  }

  Widget backButton() {
    return CustomBackButton(onPressed: () async {
      await cubit.showLoading();
      Navigator.of(context).pop(true);
      await cubit.hideLoading();
    });
  }

  Widget profileCustom() {
    return AppIconButton(
        onPressed: () {
          cubit.showLoading();
          context.router.pushNamed(Routes.userprofile);
          cubit.hideLoading();
        },
        icon: Row(children: [
          Text(cubit.nameCustom(state.user.fullname, 8),
              style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 5),
          userImage()
        ]));
  }

  Widget userImage() {
    return ClipOval(
        child: (state.user.avatarUrl == "")
            ? Image.asset(AppImages.imgProfile128x128,
                fit: BoxFit.cover,
                width: AppDimens.size30.width,
                height: AppDimens.size30.height)
            : Image.network(state.user.avatarUrl,
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
                  cubit.showLoading();
                  await _onSearch(
                      _formKey.currentState!.fields['search']?.value);
                  cubit.hideLoading();
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
    if (list.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [topicButton(list[index])],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.95, crossAxisSpacing: 14),
      );
    } else {
      return Container(
          width: state.width * 0.9,
          height: state.height,
          alignment: Alignment.center,
          child: Text(LanguageKeys.empty_favorite_stories.tr,
              style: const TextStyle(fontSize: 20)));
    }
  }

  Widget topicButton(TopicButtonObject btnObject) {
    return GestureDetector(
        onTap: () async {
          await _onChangeBottomBarState();
          cubit.showLoading();
          await _setCurrentStoryTopic(btnObject.id);
          context.router.pushNamed(Routes.storytopic);
          cubit.hideLoading();
          await _onChangeBottomBarState();
        },
        child: Container(
            width: state.width * 0.39,
            height: state.width * 0.39,
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
          await _onChangeBottomBarState();
          cubit.showLoading();
          await cubit.getStory(context, btnObject.id!);
          await cubit.createOrGetUserStory(context, btnObject.id!);
          await _navigateToOverviewPage();
          cubit.hideLoading();
          await _onChangeBottomBarState();
        },
        child: Container(
            width: state.width * 0.37,
            height: state.width * 0.37,
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
      width: state.width,
      height: state.width * 0.25,
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
        width: state.width * 0.28,
        child: Text(cubit.customContent(title, 30),
            style: const TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
            softWrap: true,
            textAlign: TextAlign.center));
  }

  Widget recommendedList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(LanguageKeys.recommended.tr,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500)),
        GestureDetector(
            onTap: () async {
              cubit.showLoading();
              await cubit.updateSearching(context, text: '');
              widget.onPageChanged(2);
              cubit.hideLoading();
            },
            child: Text(LanguageKeys.view.tr,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500))),
      ]),
      const SizedBox(height: 10),
      SizedBox(
          height: state.width * 0.45,
          width: state.width,
          child: listRecommendedButton(state.lstRecommend))
    ]);
  }

  Widget topicList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(LanguageKeys.topics.tr,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500)),
        const Spacer()
      ]),
      const SizedBox(height: 10),
      listTopicButton(state.lstTopic)
    ]);
  }

  Widget listRecommendedButton(List<StoryButtonObject> list) {
    if (list.isEmpty) {
      return Text("${LanguageKeys.updating.tr} !");
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
    await cubit.updateSearching(context, text: value);
    widget.onPageChanged(2);
  }

  Future<void> _navigateToOverviewPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              StoryOverviewPage(onClosed: (String value) async {})),
    );
  }

  Future<void> _setCurrentStoryTopic(String id) async {
    await cubit.updateCurrentStoryTopic(context, id);
  }

  Future<void> _onChangeBottomBarState() async {
    setState(() {
      widget.toggleBottomBarVisibility();
    });
  }

  Future<void> _initCubit() async {
    await cubit.init(context);
    await _onChangeBottomBarState();
  }

  @override
  void initState() {
    super.initState();
    _initCubit();
  }
}
