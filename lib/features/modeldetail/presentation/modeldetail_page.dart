import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/modeldetail/components/model_detail_loading.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_cubit.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../app/config/routes.dart';
import '../../../base/base_state.dart';

@RoutePage()
class ModelDetailPage extends StatefulWidget {
  const ModelDetailPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<ModelDetailState, ModelDetailCubit, ModelDetailPage> {
  bool download = false;
  String valueName = "";
  String type = "";

  @override
  void initState() {
    cubit.init(context);
    super.initState();
  }

  @override
  Widget buildByState(BuildContext context, ModelDetailState state) {
    return state.isLoaded
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                centerTitle: true,
                title: const Text("Animal Detail",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const Column(
                    mainAxisAlignment: MainAxisAlignment.center, children: []),
                actions: const []),
            body: Stack(children: [
              SizedBox(width: state.width, height: state.height),
              backgroundPage(context),
              backButton()
            ]))
        : ModelDetailLoading(isClosedLoading: cubit.isClosedLoading);
  }

  Widget backgroundPage(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(children: [
      Container(
          constraints: BoxConstraints(minHeight: state.height),
          width: state.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [state.backgroundColor.withOpacity(0.5), Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: whiteLayoutPage()),
      loadArButton(),
      modelImage(state.imagePath),
    ]));
  }

  Widget modelImage(String url) {
    return Positioned(
        left: 0,
        right: 0,
        top: state.height * 0.1,
        child: Align(alignment: Alignment.center, child: loadImage(url)));
  }

  Widget loadImage(String url) {
    return Image.network(url, width: state.width * 0.45, fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
      print("Load image from URL fail: $error");
      return Image.asset(AppImages.imgAppLogo,
          width: state.width * 0.45, fit: BoxFit.cover);
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
            top: state.height * 0.3, left: 20, right: 20, bottom: 25),
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
                      width: state.width * 0.11,
                      height: state.width * 0.11,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.6))),
                  ClipRect(
                      child: Image.asset(AppIcons.icX,
                          width: state.width * 0.1, fit: BoxFit.cover))
                ]))));
  }

  Widget modelInformation() {
    return Column(children: [
      SizedBox(height: state.height * 0.07),
      Center(
          child: Stack(
              alignment: Alignment.center,
              children: [modelTitle(state.animalTitle), views(state.views)])),
      const SizedBox(height: 15),
      Container(height: 2, width: double.infinity, color: Colors.grey),
      const SizedBox(height: 15),
      informationRow("Description:", state.description),
      informationRow("Biological Classification:", state.classification),
      informationRow("Conservation:", state.conservation),
      informationRow("Reproduction:", state.reproduction),
      informationRow("Cultural Depiction:", state.culturalFigure),
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
                  width: state.width * 0.1, fit: BoxFit.cover)),
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
              width: state.width * 0.77,
              child: Text(content,
                  style: const TextStyle(fontSize: 15, color: Colors.black))),
          const SizedBox(width: 8)
        ]),
        const SizedBox(height: 12)
      ]);
    }
  }

  Widget loadArButton() {
    return FutureBuilder(
        future: cubit.downloadModel(
            cubit.animalController.currentAnimal.value.name,
            cubit.animalController.currentAnimal.value.type),
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
        top: state.height * 0.15,
        right: state.width * 0.05,
        child: GestureDetector(
            onTap: () => context.router.pushNamed(Routes.ar),
            child: Stack(alignment: Alignment.center, children: [
              Container(
                  width: state.width * 0.11,
                  height: state.width * 0.11,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle)),
              ClipRect(
                  child: Image.asset(AppIcons.icCamera,
                      width: state.width * 0.08, fit: BoxFit.cover))
            ])));
  }

  Widget downloadButton() {
    return Positioned(
        top: state.height * 0.15,
        right: state.width * 0.05,
        child: GestureDetector(
            onTap: () async {
              Fluttertoast.showToast(msg: "Downloading animal!");
              await downloadAndUnpack();
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                  width: state.width * 0.11,
                  height: state.width * 0.11,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle)),
              ClipRect(
                  child: Image.asset(AppIcons.icWhiteDownload,
                      width: state.width * 0.07, fit: BoxFit.cover))
            ])));
  }

  Future<void> downloadAndUnpack() async {
    await cubit.downloadAndUnpack(
        cubit.animalController.currentAnimal.value.name,
        cubit.animalController.currentAnimal.value.type);
    setState(() {
      valueName = cubit.animalController.currentAnimal.value.name;
      type = cubit.animalController.currentAnimal.value.type;
    });
  }
}
