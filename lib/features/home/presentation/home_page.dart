import 'dart:async';

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/base-model/button_object.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/features/home/component/home_activity_button.dart';
import 'package:ar_zoo_explorers/features/home/component/home_category_button.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../app/config/routes.dart';
import '../../../base/widgets/page_loading_indicator.dart';
import '../../../core/data/controller/animal_detail_controller.dart';
import '../../account/accountmanager/presentation/accountmanager_page.dart';
import 'home_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<HomeState, HomeCubit, HomePage> {
  final PageController advertisementController = PageController();
  final detailController = AnimalDetailController.findOrInitialize;
  AudioPlayer audioPlayer = AudioPlayer();

  final _formKey = GlobalKey<FormBuilderState>();

  List<Widget> imageSliders = [];
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _initCubit();
  }

  void _playAudioWithDelay() {
    Timer(const Duration(seconds: 2), () {
      audioPlayer.play(AssetSource(AppSound.audioHome));
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is resumed, play the audio
      _playAudioWithDelay();
    } else if (state == AppLifecycleState.paused) {
      // App is paused, stop the audio
      audioPlayer.stop();
    }
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                    backgroundColor: AppColor.appBarColor,
                    centerTitle: true,
                    elevation: 1,
                    title: Text(
                      LanguageKeys.home.tr.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [settingButton()]),
                    actions: [profileCustom(), const SizedBox(width: 15)]),
                body: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.white,
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 50),
                      child: Column(children: [
                        const SizedBox(height: 12),
                        carouselSlider(),
                        searchBar(state.searchBar),
                        const SizedBox(height: 20),
                        listOptionButton(context),
                        const SizedBox(height: 24),
                        listModelButton(state.listAnimalCategory),
                      ]),
                    ),
                  ),
                )))));
  }

  Widget listOptionButton(BuildContext context) {
    return Column(
      children: [
        componentTitle(LanguageKeys.kidsActivities.tr),
        const SizedBox(height: 16),
        optionButton(context, AppImages.imgArBaby_WhiteBG,
            LanguageKeys.chat_ai.tr, Routes.chatai),
        const SizedBox(height: 16),
        optionButton(context, AppImages.imgStoryTelling,
            LanguageKeys.tellStoriesForChildren.tr, Routes.story),
        const SizedBox(height: 16),
        optionButton(context, AppImages.imgLearning,
            LanguageKeys.learnWithChildren.tr, Routes.learning)
      ],
    );
  }

  Widget optionButton(
      BuildContext context, String imageUrl, String content, String routePage) {
    return GestureDetector(
        onTap: () async {
          audioPlayer.dispose();
          await _onTapActivityButton(context, routePage);
        },
        child: HomeActivityButton(imageUrl: imageUrl, content: content));
  }

  Widget profileCustom() {
    return AppIconButton(
        onPressed: () async {
          await cubit.showLoading();
          context.router.pushNamed(Routes.userprofile);
          await cubit.hideLoading();
        },
        icon: Row(children: [
          Text(cubit.nameCustom(cubit.controller.currentUser.value.fullname, 8),
              style: const TextStyle(color: AppColor.white)),
          const SizedBox(width: 5),
          userImage()
        ]));
  }

  Widget userImage() {
    return ClipOval(
        child: (cubit.controller.currentUser.value.avatarUrl == "")
            ? Image.asset(AppImages.imgProfile128x128,
                fit: BoxFit.cover,
                width: AppDimens.size30.width,
                height: AppDimens.size30.height)
            : Image.network(cubit.controller.currentUser.value.avatarUrl,
                fit: BoxFit.cover,
                width: AppDimens.size30.width,
                height: AppDimens.size30.height));
  }

  Widget settingButton() {
    return AppIconButton(
        onPressed: () async {
          await cubit.showLoading();
          _turnSettingPage();
          await cubit.hideLoading();
        },
        icon: const Icon(Icons.settings, color: AppColor.white),
        borderRadius: AppDimens.radius200,
        padding: const EdgeInsets.all(AppDimens.spacing5),
        width: AppDimens.size30.width,
        height: AppDimens.size30.height,
        backgroundColor: AppColorScheme.dark().cardColor);
  }

  Widget carouselSlider() {
    return Column(children: [
      advertisementImages(),
      const SizedBox(height: 10),
      advertisementIndicators(),
      const SizedBox(height: 10),
    ]);
  }

  Widget advertisementImages() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        enlargeCenterPage: true,
        onPageChanged: (index, reason) async {
          await cubit
              .onChangeCurrentAdsPage(index)
              .then((value) => setState(() {}));
        },
      ),
      items: imageSliders,
    );
  }

  Widget advertisementIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageSliders.map((item) {
        int index = imageSliders.indexOf(item);
        return Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: state.currentAdsPage == index
                ? Colors.blue.shade600
                : Colors.grey,
          ),
        );
      }).toList(),
    );
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
                  await cubit.showLoading();
                  await _onSearch(
                      _formKey.currentState!.fields['search']?.value);
                  await cubit.hideLoading();
                },
                icon: Image.asset(item.icon_suffix)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25)),
        style: const TextStyle(fontSize: 16),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([]));
  }

  // DANH SÁCH BUTTON MODEL
  Widget listModelButton(List<ButtonObject> list) {
    return Column(children: [
      componentTitle(LanguageKeys.categories.tr),
      GridView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [modelButton(index)],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.9, crossAxisSpacing: 14),
      ),
    ]);
  }

  Widget componentTitle(String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: state.width, height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            Text(content,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  // MODEL BUTTON
  Widget modelButton(int index) {
    return GestureDetector(
        onTap: () async => {
              await cubit.showLoading(),
              await _setCurrentCategory(index),
              context.router.pushNamed(Routes.animalmodels),
              await cubit.hideLoading(),
            },
        child: HomeCategoryButton(item: state.listAnimalCategory[index]));
  }

  void _turnSettingPage() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return const AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: 1.0, // Độ mờ 80%
            //child: SettingPage(),
            child: AccountManagerPage(),
          );
        }));
  }

  Future<void> _onTapActivityButton(
      BuildContext context, String routePage) async {
    await cubit.showLoading();
    context.router.pushNamed(routePage);
    if (routePage == Routes.story) {
      await _getAllTopics(context);
      await _getStoriesByReleaseDate(context);
    }
    await cubit.hideLoading();
  }

  Future<void> _buildSlider() async {
    advertisementController.addListener(() async {
      await cubit
          .onChangeCurrentAdsPage(advertisementController.page!.round())
          .then((value) => setState(() {}));
    });
  }

  Future<void> _setCurrentCategory(int index) async {
    await cubit.setCurrentCategory(context, index);
  }

  Future<void> _onSearch(String? value) async {
    await cubit.onSearch(value);
    context.router.pushNamed(Routes.searchmodel);
  }

  Future<void> _addAdvertiseImage() async {
    for (var item in state.lstAdvertisement) {
      imageSliders.add(ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(item, fit: BoxFit.cover)));
    }
  }

  Future<void> _getAllTopics(BuildContext context) async {
    await cubit.getAllTopics(context);
  }

  Future<void> _getStoriesByReleaseDate(BuildContext context) async {
    await cubit.getStoriesByReleaseDate(context);
  }

  Future<void> _initCubit() async {
    await cubit.init(context);
    await _buildSlider();
    await _addAdvertiseImage().then((value) => setState(() {}));
  }
}
