import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/model_category_controller.dart';
import 'package:ar_zoo_explorers/features/base-model/button_object.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelBottomSheet extends StatefulWidget {
  final ValueChanged<String> onTapped;
  final List<String> lstModelId;
  const ModelBottomSheet({
    required this.lstModelId,
    required this.onTapped,
    super.key,
  });

  @override
  _ModelBottomSheetState createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  final aniCateController = ModelCategoryController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;

  List<ButtonObject> lstButton = [];

  double width = 0;
  double height = 0;
  final languageCode = Get.locale?.languageCode;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: width,
        height: height * 0.3,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(height * 0.025),
            topRight: Radius.circular(height * 0.025),
          ),
        ),
        child: Column(children: [
          SizedBox(
            width: width,
            height: height * 0.075,
          ),
          Expanded(child: Center(child: listRecommendedButton(lstButton)))
        ]),
      ),
      topSection()
    ]);
  }

  Widget topSection() {
    return Container(
        width: width,
        height: height * 0.075,
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(height * 0.025),
              topRight: Radius.circular(height * 0.025),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 4))
            ]),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              height: height * 0.01,
              width: width * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height * 0.005),
                  color: Colors.grey)),
        ]));
  }

  Widget listRecommendedButton(List<ButtonObject> list) {
    if (list.isEmpty) {
      return Text("${LanguageKeys.updating.tr} !");
    }
    List<Widget> listRow = [];
    for (int i = 0; i < list.length; i = i + 1) {
      listRow.add(modelButton(i));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Row(children: listRow));
  }

  // MODEL BUTTON
  Widget modelButton(int index) {
    return GestureDetector(
        onTap: () async => {
              widget.onTapped(lstButton[index].id!),
              Navigator.of(context).pop(),
              // await _setCurrentAnimal(index),
              // await _setCurrentCategoryAnimal(index),
              // context.router.pushNamed(Routes.modeldetail)
            },
        child: Container(
            width: MediaQuery.of(context).size.width * 0.35 + 5,
            height: MediaQuery.of(context).size.width * 0.35 + 5,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 4),
                // border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(20.0),
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
                  child: buttonImage(lstButton[index].icon)),
              Expanded(
                  child: Center(
                      child:
                          buttonTitle(lstButton[index].title[languageCode]!)))
            ])));
  }

  // TÊN MODEL
  Widget buttonTitle(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
        softWrap: true,
        textAlign: TextAlign.center);
  }

  // ẢNH ĐẠI DIỆN MODEL CỦA BUTTON
  Widget buttonImage(String url) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width * 0.255,
        height: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.grey[200]),
        child: (url == "")
            ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
            : Image.network(url, fit: BoxFit.cover));
  }

  void _setListAnimal() {
    for (var itemA in widget.lstModelId) {
      for (var itemB in animalController.listAnimal.value) {
        if (itemA == itemB.id) {
          lstButton.add(ButtonObject(title: {
            'vi': itemB.title,
            'en': itemB.title,
          }, icon: itemB.icon, id: itemB.id, cateId: itemB.categoryId));
        }
      }
    }
  }

  // Future<void> _setCurrentAnimal(int index) async {
  //   await animalController.updateCurrentAnimal(context, lstButton[index].id!);
  // }

  // Future<void> _setCurrentCategoryAnimal(int index) async {
  //   await aniCateController.updateCurrentAnimalCategory(
  //       context, lstButton[index].cateId!);
  // }

  void _setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        width = MediaQuery.of(context).size.width;
        height = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setDimension();
    _setListAnimal();
  }
}
