import 'package:ar_zoo_explorers/core/data/controller/animal_category_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_cubit.dart';
import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../app/config/app_router.gr.dart';
import '../../../app/config/routes.dart';
import '../../../app/theme/dimens.dart';
import '../../../app/theme/icons.dart';
import '../../../base/base_state.dart';
import '../../../base/widgets/page_loading_indicator.dart';
import '../../../core/data/controller/animal_detail_controller.dart';
import '../../../core/data/controller/auth_controller.dart';
import '../../../core/data/controller/user_animal_controller.dart';
import '../../../domain/entities/animal_detail_entity.dart';
import '../../../utils/widget/button_widget.dart';
import '../../base-model/button_object.dart';
import '../../base-model/form_builder_text_field_model.dart';

@RoutePage()
class AnimalModelsPage extends StatefulWidget {
  const AnimalModelsPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<AnimalModelsState, AnimalModelsCubit, AnimalModelsPage> {
  final userAnimalController = UserAnimalController.findOrInitialize;
  final detailController = AnimalDetailController.findOrInitialize;
  final controller = AuthController.findOrInitialize;
  final cateController = AnimalCategoryController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;

  final _formKey = GlobalKey<FormBuilderState>();

  String urlAvatarUser = AppIcons.icDefaultUser;

  @override
  Widget buildByState(BuildContext context, AnimalModelsState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                        cateController.currentAnimalCategory.value.title,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [turnBack()]),
                    actions: [
                      profileCustom(),
                      const SizedBox(width: 10),
                    ]),
                body: FormBuilder(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(children: [
                              const SizedBox(height: 12),
                              searchBar(cubit.searchBar),
                              const SizedBox(height: 20),
                              listModelButton(cubit.listSearchAnimal),
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
        onTap: () async {
          await setCurrentAnimal(index);
          context.router.pushNamed(Routes.modeldetail);
        },
        child: Container(
            width: cubit.WIDTH * 0.4,
            height: cubit.WIDTH * 0.4,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 6),
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: buttonImage(cubit.listSearchAnimal[index].icon)),
              Center(
                  child: Stack(alignment: Alignment.center, children: [
                buttonTitle(cubit.listSearchAnimal[index].title),
                loveButton(index),
                views(index)
              ]))
            ])));
  }

  // ẢNH ĐẠI DIỆN MODEL CỦA BUTTON
  Widget buttonImage(String url) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: cubit.WIDTH * 0.28,
      height: cubit.WIDTH * 0.28,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.grey[200]),
      child: (url == "")
          ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
          : Image.network(url, fit: BoxFit.cover),
    );
  }

  // TÊN MODEL
  Widget buttonTitle(String title) {
    return SizedBox(
        width: 80,
        child: Text(title,
            style: const TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
            softWrap: true,
            textAlign: TextAlign.center));
  }

  Widget loveButton(int index) {
    return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
                onPressed: () async {
                  setState(() {
                    cubit.isLoved(index);
                  });
                  await _updateLoveButton(context, index);
                },
                icon: Image.asset(cubit.listSearchAnimal[index].isLoved
                    ? AppIcons.icLoved
                    : AppIcons.icHeart))));
  }

  Widget searchBar(FormBuilderTextFieldModel item) {
    return FormBuilderTextField(
      name: item.name,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
          hintText: item.hint_text,
          suffixIcon: IconButton(
              onPressed: () {
                onSearch(_formKey.currentState!.fields['search']?.value);
              },
              icon: Image.asset(item.icon_suffix)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 25)),
      style: const TextStyle(fontSize: 16),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([]),
    );
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

  Widget views(int index) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.all(2),
            child: SizedBox(
                width: 28,
                height: 28,
                child: Column(children: [
                  Image.asset(AppIcons.icEye24, scale: 1.6),
                  Text(cubit.listSearchAnimal[index].views.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.black))
                ]))));
  }

  Widget turnBack() {
    return AppIconButton(
        onPressed: () async {
          await cateController.resetCurrentAnimalCategory(context);
          //context.router.pop();
          context.router.popAndPush(const HomeRoute());
        },
        icon: Image.asset(AppIcons.icBack_png, scale: 0.65));
  }

  void setAnimal(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await animalController.getAllAnimals(context);
      setState(() {
        cubit.setListAnimal(animalController.listAnimal.value,
            cateController.currentAnimalCategory.value.id);
        for (int i = 0; i < cubit.listFullAnimal.length; i++) {
          _getIsLoved(controller.currentUser.value.id, i);
          _getViews(detailController.listAnimalDetail.value, i);
        }
      });
    });
  }

  Future<void> onSearch(String? value) async {
    setState(() {
      cubit.onSearch(value ?? "");
    });
  }

  setCurrentAnimal(int index) async {
    await animalController.updateCurrentAnimal(
        context, cubit.listSearchAnimal[index].id!);
  }

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.WIDTH = MediaQuery.of(context).size.width;
      cubit.HEIGHT = MediaQuery.of(context).size.height;
    });
  }

  _getIsLoved(String userId, int index) async {
    bool status = await userAnimalController.getUserAnimalIsLoved(
        userId, cubit.listFullAnimal[index].id!);
    setState(() {
      cubit.listFullAnimal[index].isLoved = status;
      cubit.listSearchAnimal[index].isLoved = status;
    });
  }

  _updateLoveButton(BuildContext context, int index) async {
    var tempObject = await userAnimalController.getUserAnimalByUserIdAndModelId(
        context,
        userId: controller.currentUser.value.id,
        modelId: cubit.listFullAnimal[index].id!);
    await userAnimalController.updateUserAnimal(context,
        id: tempObject.id,
        userId: controller.currentUser.value.id,
        modelId: cubit.listSearchAnimal[index].id!,
        isLoved: cubit.listSearchAnimal[index].isLoved);
  }

  _getViews(List<AnimalDetailEntity> lst, int index) {
    for (int i = 0; i < lst.length; i++) {
      cubit.listFullAnimal[index].views = 0;
      cubit.listSearchAnimal[index].views = 0;
      if (cubit.listFullAnimal[index].id == lst[i].modelId) {
        cubit.listFullAnimal[index].views = lst[i].views;
        cubit.listSearchAnimal[index].views = lst[i].views;
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setDimension();
    controller.getCurrentUser(context);
    setAnimal(context);
  }
}
