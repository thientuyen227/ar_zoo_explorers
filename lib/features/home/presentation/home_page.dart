import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_category_controller.dart';
import 'package:ar_zoo_explorers/features/base-model/button_object.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/features/home/model/advertisement_object.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../app/config/routes.dart';
import '../../../base/widgets/page_loading_indicator.dart';
import '../../../core/data/controller/animal_controller.dart';
import '../../../core/data/controller/animal_detail_controller.dart';
import '../../../core/data/controller/auth_controller.dart';
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

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: const Text("Trang Chủ",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [settingButton()]),
                    actions: [profileCustom(), const SizedBox(width: 15)]),
                body: FormBuilder(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(children: [
                              const SizedBox(height: 12),
                              searchBar(cubit.searchBar),
                              carouselSlider(context, cubit.listAdvertisement),
                              listModelButton(cubit.listAnimalCategory),
                            ]))))))));
  }

  // DANH SÁCH BUTTON MODEL
  Widget listModelButton(List<ButtonObject> list) {
    List<Widget> listRow = [];
    for (int i = 0; i < list.length - 1; i = i + 2) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [modelButton(i), modelButton(i + 1)]));
      listRow.add(const SizedBox(height: 20));
    }
    if ((list.length) % 2 != 0) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modelButton(list.length - 1),
            const SizedBox(height: 150, width: 150)
          ]));
      listRow.add(const SizedBox(height: 20));
    }
    return Column(children: listRow);
  }

  // MODEL BUTTON
  Widget modelButton(int index) {
    return GestureDetector(
        onTap: () async => {
              await setCurrentCategory(index),
              context.router.pushNamed(Routes.animalmodels)
            },
        child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
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
        width: MediaQuery.of(context).size.width * 0.28,
        height: MediaQuery.of(context).size.width * 0.28,
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
        width: 80,
        child: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 11.5,
                fontWeight: FontWeight.bold),
            softWrap: true,
            textAlign: TextAlign.center));
  }

  Widget searchBar(FormBuilderTextFieldModel item) {
    return FormBuilderTextField(
        name: item.name,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: item.hint_text,
            suffixIcon: IconButton(
                onPressed: () async {
                  await onSearch(
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

  // SLIDER QUẢNG CÁO
  Widget carouselSlider(BuildContext context, AdvertisementObject items) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      advertisementImages(context, items),
      advertisementIndicator(context, items),
      const SizedBox(height: 10)
    ]);
  }

  // HÌNH ẢNH QUẢNG CÁO
  Widget advertisementImages(BuildContext context, AdvertisementObject items) {
    return Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        height: 200,
        child: PageView.builder(
            controller: advertisementController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(items.ads[index], fit: BoxFit.cover));
            }));
  }

  Widget advertisementIndicator(
      BuildContext context, AdvertisementObject items) {
    return Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(items.length, (index) {
              return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cubit.adsCurrentPage == index
                          ? Colors.blue
                          : Colors.grey));
            })));
  }

  Widget profileCustom() {
    return AppIconButton(
        onPressed: () => context.router.pushNamed(Routes.userprofile),
        icon: Row(children: [
          Text(cubit.nameCustom(controller.currentUser.value.fullname)),
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

  void _turnSettingPage() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return const AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: 1.0, // Độ mờ 80%
              child: SettingPage());
        }));
  }

  void _buildSlider() {
    advertisementController.addListener(() {
      setState(() {
        cubit.adsCurrentPage = advertisementController.page!.round();
      });
    });
  }

  void setAnimalCategory(BuildContext context) async {
    await cateController.getAllAnimalCategories(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.setListAnimalCategory(cateController.listAnimalCategory.value);
      });
    });
  }

  setCurrentCategory(int index) async {
    await cateController.updateCurrentAnimalCategory(
        context, cubit.listAnimalCategory[index].id!);
  }

  Future<void> onSearch(String? value) async {
    if (value != null) {
      value = value.trim();
    } else {
      value = "";
    }
    animalController.searchValue(value);
    context.router.pushNamed(Routes.searchmodel);
    //context.router.replace(const SearchModelRoute());
  }

  @override
  void initState() {
    super.initState();
    _buildSlider();
    controller.getCurrentUser(context);
    detailController.getAllAnimalDetails(context);
    setAnimalCategory(context);
  }
}
