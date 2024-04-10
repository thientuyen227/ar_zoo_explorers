import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/story/storyoverview/presentation/storyoverview_cubit.dart';
import 'package:ar_zoo_explorers/features/story/storyoverview/presentation/storyoverview_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StoryOverviewPage extends StatefulWidget {
  const StoryOverviewPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryOverviewState, StoryOverviewCubit,
    StoryOverviewPage> {
  @override
  Widget buildByState(BuildContext context, StoryOverviewState state) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Thông tin Chi Tiết",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomBackButton()]),
            actions: const []),
        body: backgroundPage(context));
  }

  Widget backgroundPage(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          constraints: BoxConstraints(minHeight: cubit.HEIGHT),
          width: cubit.WIDTH,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: whiteLayoutPage()),
      // loadArButton(),
      // modelImage(cubit.imagePath),
    ]));
  }

  Widget whiteLayoutPage() {
    return Container(
        constraints: BoxConstraints(maxHeight: cubit.HEIGHT * 0.9),
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
            top: cubit.HEIGHT * 0.12, left: 20, right: 20, bottom: 25),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: storyInformation());
  }

  Widget storyInformation() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      imgStory(),
      storyName(),
      Row(children: [
        fieldName("Tác giả : "),
        Expanded(
            child: Text(cubit.author,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
      ]),
      Row(children: [
        fieldName("Người đọc : "),
        Expanded(
            child: Text(cubit.reader,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
      ]),
      Row(children: [
        fieldName("Thời lượng : "),
        Text(
            '${cubit.duration.inMinutes} phút ${cubit.duration.inSeconds.remainder(60)} giây',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green))
      ]),
      Row(children: [fieldName("Danh mục : "), topicStory("Ngụ ngôn")]),
      Row(children: [fieldName("Tóm tắt : ")]),
      overview(),
      SizedBox(height: cubit.HEIGHT * 0.1),
      btnListen(),
    ]));
  }

  Widget imgStory() {
    return Center(
        child: Container(
            width: cubit.WIDTH * 0.3,
            height: cubit.WIDTH * 0.3,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 4))
                ]),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(cubit.avatar, fit: BoxFit.cover))));
  }

  Widget storyName() {
    return Center(
        child: Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: fieldName(cubit.name, isTitle: true)));
  }

  Widget fieldName(String name, {bool isTitle = false}) {
    return Text(name,
        style: TextStyle(
            fontSize: isTitle ? 20 : 16,
            fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            color: isTitle ? Colors.black : Colors.grey.shade800));
  }

  Widget topicStory(String topic) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey.shade50, borderRadius: BorderRadius.circular(5)),
        child: Text(topic,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700)));
  }

  Widget overview() {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Text(cubit.overview,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700)));
  }

  Widget btnListen() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 89, 178, 252),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            padding: const EdgeInsets.all(0),
            fixedSize: Size(cubit.WIDTH * 0.85, cubit.HEIGHT * 0.06),
            shadowColor: Colors.black),
        onPressed: () {
          context.router.pushNamed(Routes.storyplayer);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgButton(AppIcons.icPlay64),
            const SizedBox(width: 10),
            contentButton("Nghe"),
          ],
        ));
  }

  Widget imgButton(String imageUrl) {
    return ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(imageUrl,
                width: cubit.WIDTH * 0.05,
                height: cubit.WIDTH * 0.05,
                fit: BoxFit.cover)));
  }

  Widget contentButton(String content) {
    return Container(
        child: Text(
      content,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      softWrap: true,
    ));
  }

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.WIDTH = MediaQuery.of(context).size.width;
        cubit.HEIGHT = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDimension();
  }
}
