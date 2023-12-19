import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_cubit.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../app/config/routes.dart';
import '../../../base/base_state.dart';
import '../../../core/data/controller/animal_controller.dart';
import '../../../core/data/controller/animal_detail_controller.dart';

@RoutePage()
class ModelDetailPage extends StatefulWidget {
  const ModelDetailPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<ModelDetailState, ModelDetailCubit, ModelDetailPage> {
  final animalController = AnimalController.findOrInitialize;
  final detailController = AnimalDetailController.findOrInitialize;

  bool download = false;

  String valueName = "";

  String type = "";

  @override
  Widget buildByState(BuildContext context, ModelDetailState state) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            title: const Text("THÔNG TIN CHI TIẾT",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center, children: []),
            actions: const []),
        body: Stack(children: [
          SizedBox(width: cubit.WIDTH, height: cubit.HEIGHT),
          backgroundPage(context),
          backButton()
        ]));
  }

  Widget backgroundPage(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(children: [
      Container(
          constraints: BoxConstraints(minHeight: cubit.HEIGHT),
          width: cubit.WIDTH,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [cubit.backgroundColor.withOpacity(0.5), Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: whiteLayoutPage()),
      loadArButton(),
      modelImage(cubit.imagePath),
    ]));
  }

  Widget modelImage(String url) {
    return Positioned(
        left: 0,
        right: 0,
        top: cubit.HEIGHT * 0.1,
        child: Align(alignment: Alignment.center, child: loadImage(url)));
  }

  Widget loadImage(String url) {
    return Image.network(url, width: cubit.WIDTH * 0.45, fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
      print("Load image from URL fail: $error");
      return Image.asset(AppImages.imgAppLogo,
          width: cubit.WIDTH * 0.45, fit: BoxFit.cover);
    });
  }

  Widget whiteLayoutPage() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3))
            ]),
        margin: EdgeInsets.only(
            top: cubit.HEIGHT * 0.3, left: 20, right: 20, bottom: 25),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: modelInformation());
  }

  Widget backButton() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 50,
        child: Align(
            alignment: Alignment.center,
            child: GestureDetector(
                onTap: () => context.router.pop(),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      width: cubit.WIDTH * 0.11,
                      height: cubit.WIDTH * 0.11,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.6))),
                  ClipRect(
                      child: Image.asset(AppIcons.icX,
                          width: cubit.WIDTH * 0.1, fit: BoxFit.cover))
                ]))));
  }

  Widget modelInformation() {
    return Column(children: [
      SizedBox(height: cubit.HEIGHT * 0.07),
      Center(
          child: Stack(
              alignment: Alignment.center,
              children: [modelTitle(cubit.animalTitle), views(cubit.views)])),
      const SizedBox(height: 15),
      Container(height: 2, width: double.infinity, color: Colors.grey),
      const SizedBox(height: 15),
      informationRow("Mô Tả:", cubit.description),
      informationRow("Phân Loại Sinh Học:", cubit.classification),
      informationRow("Tình Trạng Bảo Tồn:", cubit.conservation),
      informationRow("Thời Kỳ Sinh Sản :", cubit.reproduction),
      informationRow("Hình tượng văn hóa:", cubit.culturalFigure),
      const SizedBox(height: 50)
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
                  width: cubit.WIDTH * 0.1, fit: BoxFit.cover)),
          Text(views.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.black))
        ]));
  }

  Widget informationRow(String title, String content) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            softWrap: true),
        const SizedBox(width: 15)
      ]),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
            width: cubit.WIDTH * 0.77,
            child: Text(content,
                style: const TextStyle(fontSize: 15, color: Colors.black))),
        const SizedBox(width: 8)
      ]),
      const SizedBox(height: 12)
    ]);
  }

  Widget loadArButton() {
    return FutureBuilder(
        future: cubit.downloadModel(animalController.currentAnimal.value.name,
            animalController.currentAnimal.value.type),
        builder: (context, snapshot) {
          final isDownload = snapshot.data;
          return arButton(isDownload ?? false);
        });
  }

  Widget arButton(bool isDownload) {
    if (isDownload == false) {
      return downloadButton();
    } else {
      return cameraButton();
    }
  }

  Widget cameraButton() {
    return Positioned(
        top: cubit.HEIGHT * 0.15,
        right: cubit.WIDTH * 0.05,
        child: GestureDetector(
            onTap: () => context.router.pushNamed(Routes.ar),
            child: Stack(alignment: Alignment.center, children: [
              Container(
                  width: cubit.WIDTH * 0.11,
                  height: cubit.WIDTH * 0.11,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle)),
              ClipRect(
                  child: Image.asset(AppIcons.icCamera,
                      width: cubit.WIDTH * 0.08, fit: BoxFit.cover))
            ])));
  }

  Widget downloadButton() {
    return Positioned(
        top: cubit.HEIGHT * 0.15,
        right: cubit.WIDTH * 0.05,
        child: GestureDetector(
            onTap: () async {
              Fluttertoast.showToast(msg: "Downloading animal!");
              downloadAndUnpack();
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                  width: cubit.WIDTH * 0.11,
                  height: cubit.WIDTH * 0.11,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle)),
              ClipRect(
                  child: Image.asset(AppIcons.icWhiteDownload,
                      width: cubit.WIDTH * 0.07, fit: BoxFit.cover))
            ])));
  }

  void downloadAndUnpack() async {
    await cubit.downloadAndUnpack(animalController.currentAnimal.value.name,
        animalController.currentAnimal.value.type);
    setState(() {
      valueName = animalController.currentAnimal.value.name;
      type = animalController.currentAnimal.value.type;
    });
  }

  Future<void> setBackgroundColor(BuildContext context) async {
    Color newColor = await cubit.getBlendedColorFromImage(cubit.imagePath);
    setState(() {
      cubit.backgroundColor = newColor;
    });
  }

  Future<void> setLayout(BuildContext context) async {
    setState(() {
      cubit.animalTitle = animalController.currentAnimal.value.title;
      cubit.imagePath = animalController.currentAnimal.value.icon;
    });
  }

  Future<void> setInformation(BuildContext context) async {
    await detailController.getAnimalCategoryModelByModelId(context,
        modelId: animalController.currentAnimal.value.id);
    await detailController.updateViewsAnimalModel(context,
        id: detailController.currentAnimalDetail.value.id,
        views: (detailController.currentAnimalDetail.value.views + 1));
    setState(() {
      cubit.description =
          detailController.currentAnimalDetail.value.description;
      cubit.classification = detailController
          .currentAnimalDetail.value.classification; // Phân loại sinh học
      cubit.conservation = detailController
          .currentAnimalDetail.value.conservation; // Tình trạng bảo tồn
      cubit.reproduction =
          detailController.currentAnimalDetail.value.reproduction; // Sinh sản
      cubit.culturalFigure = detailController
          .currentAnimalDetail.value.culturalFigure; // Hình tượng trong văn hóa
      cubit.views = detailController.currentAnimalDetail.value.views;
    });
  }

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.WIDTH = MediaQuery.of(context).size.width;
      cubit.HEIGHT = MediaQuery.of(context).size.height;
    });
  }

  @override
  void initState() {
    super.initState();

    setLayout(context);
    setBackgroundColor(context);

    setInformation(context);
    setDimension();
  }
}
