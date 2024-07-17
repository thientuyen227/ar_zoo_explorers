import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/model_category_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/model_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailModel extends StatefulWidget {
  final String modelId;
  const DetailModel({super.key, required this.modelId});
  @override
  _DetailModelState createState() => _DetailModelState();
}

class _DetailModelState extends State<DetailModel> {
  double width = 0;
  double height = 0;

  String categoryId = '';
  final String toysId = 'I3EbPxzSEmvE0R1Q6kGQ';
  final String fruitsId = 'NMPTfkwY7sF2HUqiweyz';

  final animalController = AnimalController.findOrInitialize;
  final cateController = ModelCategoryController.findOrInitialize;
  final detailController = ModelDetailController.findOrInitialize;

  final languageCode = Get.locale?.languageCode;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animalController.getAnimal(context, id: widget.modelId);
    categoryId = animalController.currentAnimal.value.categoryId;
    cateController.getModelCategory(context, id: categoryId);
    _setDimension();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: height * 0.07),
      Center(
          child: Stack(alignment: Alignment.center, children: [
        modelTitle(animalController.currentAnimal.value.titles[languageCode]!),
        views(detailController.currentModelDetail.value.views)
      ])),
      const SizedBox(height: 15),
      Container(height: 2, width: double.infinity, color: Colors.grey),
      const SizedBox(height: 15),
      lstInformation(),
      const SizedBox(height: 50)
    ]);
  }

  Widget lstInformation() {
    if (categoryId == toysId) {
      return lstToysInformation();
    } else if (categoryId == fruitsId) {
      return lstFruitsInformation();
    } else
      return lstBasicInformation();
  }

  Widget lstFruitsInformation() {
    return Column(children: [
      informationRow("${(LanguageKeys.description.tr)}:",
          detailController.currentModelDetail.value.description[languageCode]!),
      informationRow(
          "${(LanguageKeys.classification.tr)}:",
          detailController
              .currentModelDetail.value.classification[languageCode]!),
      informationRow(
          "${(LanguageKeys.reproduction.tr)}:",
          detailController
              .currentModelDetail.value.reproduction[languageCode]!),
      informationRow(
          "${(LanguageKeys.preservation.tr)}:",
          detailController
              .currentModelDetail.value.preservation[languageCode]!),
      informationRow(
          "${(LanguageKeys.culturalSignificance.tr)}:",
          detailController
              .currentModelDetail.value.culturalSignificance[languageCode]!),
    ]);
  }

  Widget lstToysInformation() {
    return Column(children: [
      informationRow("${(LanguageKeys.description.tr)}:",
          detailController.currentModelDetail.value.description[languageCode]!),
      informationRow(
          "${(LanguageKeys.classification.tr)}:",
          detailController
              .currentModelDetail.value.classification[languageCode]!),
      informationRow("${(LanguageKeys.maintenance.tr)}:",
          detailController.currentModelDetail.value.maintenance[languageCode]!),
      informationRow(
          "${(LanguageKeys.manufacturing.tr)}:",
          detailController
              .currentModelDetail.value.manufacturing[languageCode]!),
      informationRow(
          "${(LanguageKeys.educationalValue.tr)}:",
          detailController
              .currentModelDetail.value.educationalValue[languageCode]!),
    ]);
  }

  Widget lstBasicInformation() {
    return Column(children: [
      informationRow("${(LanguageKeys.description.tr)}:",
          detailController.currentModelDetail.value.description[languageCode]!),
      informationRow(
          "${(LanguageKeys.classification.tr)}:",
          detailController
              .currentModelDetail.value.classification[languageCode]!),
      informationRow(
          "${(LanguageKeys.conservation.tr)}:",
          detailController
              .currentModelDetail.value.conservation[languageCode]!),
      informationRow(
          "${(LanguageKeys.preservation.tr)}:",
          detailController
              .currentModelDetail.value.preservation[languageCode]!),
      informationRow(
          "${(LanguageKeys.reproduction.tr)}:",
          detailController
              .currentModelDetail.value.reproduction[languageCode]!),
      informationRow("${(LanguageKeys.maintenance.tr)}:",
          detailController.currentModelDetail.value.maintenance[languageCode]!),
      informationRow(
          "${(LanguageKeys.manufacturing.tr)}:",
          detailController
              .currentModelDetail.value.manufacturing[languageCode]!),
      informationRow(
          "${(LanguageKeys.culturalFigure.tr)}:",
          detailController
              .currentModelDetail.value.culturalFigure[languageCode]!),
      informationRow(
          "${(LanguageKeys.culturalSignificance.tr)}:",
          detailController
              .currentModelDetail.value.culturalSignificance[languageCode]!),
      informationRow(
          "${(LanguageKeys.educationalValue.tr)}:",
          detailController
              .currentModelDetail.value.educationalValue[languageCode]!),
    ]);
  }

  Widget modelTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black));
  }

  Widget views(int views) {
    return Align(
        alignment: Alignment.centerRight,
        child: Column(children: [
          ClipRect(
              child: Image.asset(AppIcons.icEye,
                  width: width * 0.1, fit: BoxFit.cover)),
          Text(views.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.black))
        ]));
  }

  Widget informationRow(String title, String content) {
    if (content == "") {
      return Container();
    } else {
      return Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              softWrap: true),
          const SizedBox(width: 15)
        ]),
        const SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              width: width * 0.77,
              child: Text(content,
                  style: const TextStyle(fontSize: 15, color: Colors.black))),
          const SizedBox(width: 8)
        ]),
        const SizedBox(height: 12)
      ]);
    }
  }

  Future<void> _setDimension() async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    setState(() {
      width = mediaSize.width;
      height = mediaSize.height;
    });
  }
}
