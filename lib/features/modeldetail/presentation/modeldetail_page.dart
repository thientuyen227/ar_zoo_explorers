import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_cubit.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app/config/routes.dart';
import '../../../base/base_state.dart';
import '../../../core/data/controller/animal_controller.dart';

@RoutePage()
class ModelDetailPage extends StatefulWidget {
  const ModelDetailPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<ModelDetailState, ModelDetailCubit, ModelDetailPage> {
  final animalController = AnimalController.findOrInitialize;

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
          BackgroundPage(context),
          BackButton()
        ]));
  }

  Widget BackgroundPage(BuildContext context) {
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
          child: WhiteLayoutPage()),
      ModelImage(cubit.imagePath),
      CameraButton()
    ]));
  }

  Widget ModelImage(String url) {
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

  Widget WhiteLayoutPage() {
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
        child: ModelInformation());
  }

  Widget BackButton() {
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

  Widget ModelInformation() {
    return Column(children: [
      SizedBox(height: cubit.HEIGHT * 0.07),
      Center(
          child: Stack(
              alignment: Alignment.center,
              children: [ModelTitle(cubit.animalTitle), Views(1000)])),
      const SizedBox(height: 15),
      Container(height: 2, width: double.infinity, color: Colors.grey),
      const SizedBox(height: 15),
      InformationRow("Mô Tả:",
          "Voi là một loài động vật lớn, có vú và sống chủ yếu ở châu Phi và châu Á. Chúng thuộc họ Elephantidae."),
      InformationRow("Phân Loại Sinh Học:", "Động vật có vú."),
      InformationRow("Tình Trạng Bảo Tồn:",
          "Tình trạng bảo tồn: Tùy thuộc vào loài, tình trạng bảo tồn của voi có thể là 'Nguy cấp' đến 'An toàn."),
      InformationRow("Thời Kỳ Sinh Sản và Phương Tiện Sinh Sản:",
          "Voi sinh sản bằng cách đẻ con và thời kỳ sinh sản thường diễn ra trong mùa khô."),
      InformationRow("Các Sự Kiện Nổi Bật:",
          "Voi thường xuất hiện trong văn hóa và tôn giáo của nhiều dân tộc ở châu Phi và châu Á."),
      InformationRow("Link Tài Liệu Hoặc Video:", "Xem thêm về Voi tại đây"),
      const SizedBox(height: 50)
    ]);
  }

  Widget ModelTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black));
  }

  Widget Views(int views) {
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

  Widget InformationRow(String title, String content) {
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

  Widget CameraButton() {
    return Positioned(
        top: cubit.HEIGHT * 0.15,
        right: 10,
        child: MaterialButton(
            onPressed: () {
              context.router.pushNamed(Routes.testunity);
            },
            child: ClipRect(
                child: Image.asset(AppIcons.icCamera,
                    width: cubit.WIDTH * 0.11, fit: BoxFit.cover))));
  }

  Future<void> setBackgroundColor(BuildContext context) async {
    Color newColor = await cubit.getBlendedColorFromImage(cubit.imagePath);
    setState(() {
      cubit.backgroundColor = newColor;
    });
  }

  Future<void> setInformation(BuildContext context) async {
    setState(() {
      cubit.animalTitle = animalController.currentAnimal.value.title;
      cubit.imagePath = animalController.currentAnimal.value.icon;
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
    setInformation(context);
    setBackgroundColor(context);
    setDimension();
  }
}
