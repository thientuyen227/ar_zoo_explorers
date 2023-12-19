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
import '../../../core/data/controller/auth_controller.dart';
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
  final cateController = AnimalCategoryController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;

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
                    title: const Text("SEARCH",
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
    return Column(children: listRow);
  }

  // MODEL BUTTON
  Widget modelButton(int index) {
    return GestureDetector(
        onTap: () async => {
              await setCurrentAnimal(index),
              context.router.pushNamed(Routes.modeldetail)
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
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: buttonImage(cubit.listSearchAnimal[index].icon)),
              Center(
                  child: Stack(alignment: Alignment.center, children: [
                buttonTitle(cubit.listSearchAnimal[index].title),
                loveButton(index)
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

  Widget loveButton(int index) {
    return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    cubit.isLoved(index);
                  });
                },
                icon: Image.asset(cubit.listSearchAnimal[index].isLoved
                    ? AppIcons.icLoved
                    : AppIcons.icHeart))));
  }

  void setAnimal(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animalController.getAllAnimals(context);
      setState(() {
        cubit.setListAnimal(animalController.listAnimal.value,
            animalController.searchValue.value);
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

  @override
  void initState() {
    super.initState();
    controller.getCurrentUser(context);
    animalController.getAllAnimals(context);
    setAnimal(context);
  }
}
