import 'package:ar_zoo_explorers/core/data/controller/user_animal_controller.dart';
import 'package:ar_zoo_explorers/features/searchmodel/presentation/searchmodel_cubit.dart';
import 'package:ar_zoo_explorers/features/searchmodel/presentation/searchmodel_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../app/config/routes.dart';
import '../../../app/theme/icons.dart';
import '../../../base/base_state.dart';
import '../../../base/widgets/page_loading_indicator.dart';
import '../../../core/data/controller/animal_category_controller.dart';
import '../../../core/data/controller/animal_controller.dart';
import '../../../core/data/controller/animal_detail_controller.dart';
import '../../../core/data/controller/auth_controller.dart';
import '../../../domain/entities/animal_detail_entity.dart';
import '../../../utils/widget/button_widget.dart';
import '../../base-model/button_object.dart';
import '../../base-model/form_builder_text_field_model.dart';

@RoutePage()
class SearchModelPage extends StatefulWidget {
  const SearchModelPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<SearchModelState, SearchModelCubit, SearchModelPage> {
  final controller = AuthController.findOrInitialize;
  final detailController = AnimalDetailController.findOrInitialize;
  final cateController = AnimalCategoryController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;
  final userAnimalController = UserAnimalController.findOrInitialize;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildByState(BuildContext context, SearchModelState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: const Text("Search",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [turnBack()]),
                    actions: const []),
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
                              const SizedBox(height: 20),
                            ]))))))));
  }

  Widget turnBack() {
    return AppIconButton(
        onPressed: () async {
          await animalController.resetCurrentValue(context);
          context.router.pop();
          context.router.pushNamed(Routes.home);
        },
        icon: Image.asset(AppIcons.icBack_png, scale: 0.65));
  }

  Widget searchBar(FormBuilderTextFieldModel item) {
    return FormBuilderTextField(
        name: item.name,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: item.hint_text,
            suffixIcon: IconButton(
                onPressed: () async {
                  onSearch(_formKey.currentState!.fields['search']?.value);
                },
                icon: Image.asset(item.icon_suffix)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25)),
        initialValue: animalController.searchValue.value,
        style: const TextStyle(fontSize: 16),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([]));
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
    if (listRow.isEmpty &&
        _formKey.currentState?.fields['search']?.value != null) {
      return const Text(
        "This model does not exist!",
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Column(children: listRow);
    }
  }

  // MODEL BUTTON
  Widget modelButton(int index) {
    return GestureDetector(
        onTap: () async => {
              await setCurrentAnimal(index),
              context.router.pushNamed(Routes.modeldetail)
            },
        child: Container(
            width: MediaQuery.of(context).size.width * 0.4 + 5,
            height: MediaQuery.of(context).size.width * 0.4 + 5,
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
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: buttonImage(cubit.listSearchAnimal[index].icon)),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    views(index),
                    const SizedBox(width: 5),
                    Expanded(
                        child:
                            buttonTitle(cubit.listSearchAnimal[index].title)),
                    loveButton(index),
                  ]))
            ])));
  }

  // ẢNH ĐẠI DIỆN MODEL CỦA BUTTON
  Widget buttonImage(String url) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width * 0.27,
        height: MediaQuery.of(context).size.width * 0.27,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.grey[200]),
        child: (url == "")
            ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
            : Image.network(url, fit: BoxFit.cover));
  }

  // TÊN MODEL
  Widget buttonTitle(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
        softWrap: true,
        textAlign: TextAlign.center);
  }

  Widget loveButton(int index) {
    return SizedBox(
        width: 30,
        height: 30,
        child: IconButton(
            onPressed: () async {
              setState(() {
                cubit.isLoved(index);
              });
              await _updateLoveButton(context, index);
            },
            icon: Image.asset(
                cubit.listSearchAnimal[index].isLoved
                    ? AppIcons.icLoved
                    : AppIcons.icHeart,
                fit: BoxFit.cover)));
  }

  Widget views(int index) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          SizedBox(
              width: 12,
              height: 12,
              child: Image.asset(AppIcons.icEye24, fit: BoxFit.cover)),
          Text(cubit.listSearchAnimal[index].views.toString(),
              style: const TextStyle(fontSize: 8, color: Colors.black))
        ]));
  }

  Future<void> setAnimal(BuildContext context) async {
    await animalController.getAllAnimals(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //print("1: ${animalController.listAnimal.value.length}");
      setState(() {
        cubit.setListAnimal(animalController.listAnimal.value,
            animalController.searchValue.value);
        for (int i = 0; i < cubit.listFullAnimal.length; i++) {
          _getIsLoved(controller.currentUser.value.id, i);
          _getViews(detailController.listAnimalDetail.value, i);
        }
      });
    });
  }

  setCurrentAnimal(int index) async {
    await animalController.updateCurrentAnimal(
        context, cubit.listSearchAnimal[index].id!);
  }

  Future<void> onSearch(String? value) async {
    await animalController.setSearchValue(
        context, _formKey.currentState!.fields['search']?.value);
    setState(() {
      cubit.onSearch(value ?? "");
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

  @override
  void initState() {
    super.initState();
    controller.getCurrentUser(context);
    animalController.getAllAnimals(context);
    setAnimal(context);
    //print("2: ${animalController.listAnimal.value.length}");
  }
}
