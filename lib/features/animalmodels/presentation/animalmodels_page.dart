import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_cubit.dart';
import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_state.dart';
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
class AnimalModelsPage extends StatefulWidget {
  const AnimalModelsPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<AnimalModelsState, AnimalModelsCubit, AnimalModelsPage> {
  final controller = AuthController.findOrInitialize;
  final _formKey = GlobalKey<FormBuilderState>();

  String urlAvatarUser = AppIcons.icDefaultUser;
  String txtSearch = "";

  @override
  Widget buildByState(BuildContext context, AnimalModelsState state) {
    return Obx(() => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageLoadingIndicator(
            future: null,
            scaffold: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: const Text("Animal Models",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [TurnBack()]),
                    actions: [
                      ProfileCustom(),
                      const SizedBox(width: 10),
                    ]),
                body: FormBuilder(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(children: [
                              const SizedBox(height: 12),
                              SearchBar(cubit.searchBar),
                              const SizedBox(height: 20),
                              ListModelButton(cubit.listButtonObject),
                            ]))))))));
  }

  // DANH SÁCH BUTTON MODEL
  Widget ListModelButton(List<ButtonObject> list) {
    List<Widget> listRow = [];
    for (int i = 0; i < list.length - 1; i = i + 2) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ModelButton(i), ModelButton(i + 1)]));
      listRow.add(const SizedBox(height: 20));
    }
    if ((list.length) % 2 != 0) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ModelButton(list.length - 1),
            const SizedBox(height: 150, width: 150)
          ]));
      listRow.add(const SizedBox(height: 20));
    }
    return Column(children: listRow);
  }

  // MODEL BUTTON
  Widget ModelButton(int index) {
    return GestureDetector(
        onTap: () => context.router.pushNamed(Routes.modeldetail),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
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
                  child: ButtonImage(cubit.listButtonObject[index].icon)),
              Center(
                  child: Stack(alignment: Alignment.center, children: [
                ButtonTitle(cubit.listButtonObject[index].title),
                LoveButton(index)
              ]))
            ])));
  }

  // ẢNH ĐẠI DIỆN MODEL CỦA BUTTON
  Widget ButtonImage(String url) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width * 0.28,
        height: MediaQuery.of(context).size.width * 0.28,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.grey[200]),
        child: Image.asset(url, fit: BoxFit.cover));
  }

  // TÊN MODEL
  Widget ButtonTitle(String title) {
    return SizedBox(
        width: 80,
        child: Text(title,
            style: const TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
            softWrap: true,
            textAlign: TextAlign.center));
  }

  Widget LoveButton(int index) {
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
                icon: Image.asset(cubit.listButtonObject[index].isLoved
                    ? AppIcons.icLoved
                    : AppIcons.icHeart))));
  }

  Widget SearchBar(FormBuilderTextFieldModel item) {
    return FormBuilderTextField(
      name: item.name,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        setState(() {
          txtSearch = value!;
        });
      },
      decoration: InputDecoration(
          hintText: item.hint_text,
          suffixIcon: IconButton(
              onPressed: () {
                cubit.onSearch(_formKey.currentState!.fields['search']?.value);
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

  Widget ProfileCustom() {
    return AppIconButton(
        onPressed: () {
          context.router.pushNamed(Routes.userprofile);
        },
        icon: Row(children: [
          Text(cubit.nameCustom(controller.currentUser.value.fullname)),
          const SizedBox(width: 5),
          Image.asset(urlAvatarUser,
              width: AppDimens.size30.width, height: AppDimens.size30.height)
        ]));
  }

  Widget TurnBack() {
    return AppIconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: Image.asset(AppIcons.icBack_png, scale: 0.65));
  }

  @override
  void initState() {
    super.initState();
    controller.getCurrentUser(context);
    cubit.listButtonObject = cubit.reptiles;
  }
}
