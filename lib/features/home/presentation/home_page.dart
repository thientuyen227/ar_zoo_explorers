import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_category_controller.dart';
import 'package:ar_zoo_explorers/features/base-model/button_object.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../app/config/routes.dart';
import '../../../base/widgets/page_loading_indicator.dart';
import '../../../core/data/controller/animal_controller.dart';
import '../../../core/data/controller/animal_detail_controller.dart';
import '../../../core/data/controller/auth_controller.dart';
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
  final controller = AuthController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;
  final cateController = AnimalCategoryController.findOrInitialize;

  final _formKey = GlobalKey<FormBuilderState>();

  List<Widget> imageSliders = [];

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 109, 189, 255),
                    centerTitle: true,
                    elevation: 1,
                    title: const Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
                      color: Colors.white,
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 50),
                      child: Column(children: [
                        const SizedBox(height: 12),
                        carouselSlider(),
                        searchBar(cubit.searchBar),
                        const SizedBox(height: 20),
                        listOptionButton(),
                        const SizedBox(height: 24),
                        listModelButton(cubit.listAnimalCategory),
                      ]),
                    ),
                  ),
                )))));
  }

  Widget listOptionButton() {
    return Column(
      children: [
        componentTitle("Options"),
        optionButton(AppImages.imgStoryTelling, "Tell stories for children",
            Routes.story),
        const SizedBox(height: 16),
        optionButton(
            AppImages.imgLearning, "Learn with children", Routes.learning)
      ],
    );
  }

  Widget optionButton(String imageUrl, String content, String routePage) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 89, 178, 252),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            padding: const EdgeInsets.all(0),
            fixedSize: Size(cubit.WIDTH * 0.85, cubit.HEIGHT * 0.1),
            shadowColor: Colors.black),
        onPressed: () {
          context.router.pushNamed(routePage);
        },
        child: Row(
          children: [
            const SizedBox(width: 10),
            optionButtonImage(imageUrl),
            const SizedBox(width: 10),
            optionButtonContent(content),
          ],
        ));
  }

  Widget optionButtonImage(String imageUrl) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(imageUrl,
            width: cubit.HEIGHT * 0.08,
            height: cubit.HEIGHT * 0.08,
            fit: BoxFit.cover));
  }

  Widget optionButtonContent(String content) {
    return SizedBox(
        width: cubit.WIDTH * 0.55,
        child: Text(
          content,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          softWrap: true,
        ));
  }

  Widget profileCustom() {
    return AppIconButton(
        onPressed: () => context.router.pushNamed(Routes.userprofile),
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

  Widget settingButton() {
    return AppIconButton(
        onPressed: () => {_turnSettingPage()},
        icon: const Icon(Icons.settings, color: Colors.white),
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
        onPageChanged: (index, reason) {
          setState(() {
            cubit.currentAdsPage = index;
          });
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
            color: cubit.currentAdsPage == index
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

  // DANH SÁCH BUTTON MODEL
  Widget listModelButton(List<ButtonObject> list) {
    List<Widget> listRow = [componentTitle("Categories")];
    for (int i = 0; i < list.length - 1; i = i + 2) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [modelButton(i), modelButton(i + 1)]));
      listRow.add(const SizedBox(height: 20));
    }
    if ((list.length) % 2 != 0) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modelButton(list.length - 1),
            const SizedBox(height: 150, width: 150)
          ]));
      listRow.add(const SizedBox(height: 20));
    }
    return Column(children: listRow);
  }

  Widget componentTitle(String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: cubit.WIDTH, height: 10),
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
              await _setCurrentCategory(index),
              context.router.pushNamed(Routes.animalmodels)
            },
        child: Container(
            width: cubit.WIDTH * 0.37,
            height: cubit.WIDTH * 0.37,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 7),
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            child: Column(children: [
              buttonImage(cubit.listAnimalCategory[index].icon),
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: buttonTitle(cubit.listAnimalCategory[index].title)),
            ])));
  }

  // ẢNH ĐẠI DIỆN MODEL CỦA BUTTON
  Widget buttonImage(String url) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        width: cubit.WIDTH * 0.23,
        height: cubit.WIDTH * 0.23,
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.white, width: 3),
            //image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white),
        child: (url == "")
            ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
            : Image.network(url, fit: BoxFit.cover));
  }

  // TÊN MODEL
  Widget buttonTitle(String title) {
    return SizedBox(
        width: cubit.WIDTH * 0.24,
        child: Text(title,
            style: const TextStyle(
                color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
            softWrap: true,
            textAlign: TextAlign.center));
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

  void _buildSlider() {
    advertisementController.addListener(() {
      setState(() {
        cubit.adsCurrentPage = advertisementController.page!.round();
      });
    });
  }

  void _setAnimalCategory(BuildContext context) async {
    await cateController.getAllAnimalCategories(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.setListAnimalCategory(cateController.listAnimalCategory.value);
      });
    });
  }

  _setCurrentCategory(int index) async {
    await cateController.updateCurrentAnimalCategory(
        context, cubit.listAnimalCategory[index].id!);
  }

  Future<void> _onSearch(String? value) async {
    if (value != null) {
      value = value.trim();
    } else {
      value = "";
    }
    animalController.searchValue(value);
    context.router.pushNamed(Routes.searchmodel);
    //context.router.replace(const SearchModelRoute());
  }

  void _addAdvertiseImage() {
    for (int i = 0; i < cubit.lstAdvertisement.length; i++) {
      imageSliders.add(ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(cubit.lstAdvertisement[i], fit: BoxFit.cover)));
    }
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
    _buildSlider();
    _setDimension();
    controller.getCurrentUser(context);
    detailController.getAllAnimalDetails(context);
    _addAdvertiseImage();
    _setAnimalCategory(context);
  }
}
