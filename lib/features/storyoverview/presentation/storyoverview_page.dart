import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_cubit.dart';
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StoryOverviewPage extends StatefulWidget {
  final Function(String) onClosed;
  const StoryOverviewPage({super.key, required this.onClosed});

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryOverviewState, StoryOverviewCubit,
    StoryOverviewPage> {
  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  // @override
  // final loadingController = AppLoadingController();

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
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [backButton()]),
            actions: [loveButton()]),
        body: backgroundPage(context));
  }

  Widget backButton() {
    return CustomBackButton(onPressed: () async {
      await widget.onClosed(storyController.currentStory.value.id);
      Navigator.of(context).pop();
    });
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

  Widget loveButton() {
    return Container(
        width: cubit.WIDTH * 0.1,
        height: cubit.WIDTH * 0.1,
        margin: const EdgeInsets.only(right: 15),
        child: IconButton(
            onPressed: () async {
              setState(() {
                cubit.isLoved();
              });
              await _updateLoveButton(context);
            },
            icon: Image.asset(
                cubit.isFavorite
                    ? AppIcons.icHeartFull64
                    : AppIcons.icHeartEmpty64,
                fit: BoxFit.cover)));
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
      Row(children: [
        fieldName("Lượt nghe : "),
        Text('${cubit.listenCount}',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
      ]),
      Row(children: [fieldName("Danh mục : "), topicStory(cubit.topic)]),
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
        child: Text(cubit.overView,
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
        onPressed: () async {
          await _listenStory();
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

  _updateLoveButton(BuildContext context) async {
    await userStoryController.updateFavorite(context,
        id: userStoryController.currentUserStory.value.id,
        isFavorited: cubit.isFavorite);
  }

  _setStoryInformation(
      StoryEntity storyEntity, UserStoryEntity usEntity) async {
    List<String> lstTopicName = await _getListTopicNames(storyEntity.topicId);
    setState(() {
      cubit.setStoryInformation(storyEntity, usEntity, lstTopicName);
    });
  }

  Future<List<String>> _getListTopicNames(List<String> lstTopicId) async {
    List<String> lstTopicName = [];

    for (var itemA in lstTopicId) {
      for (var itemB in storyTopicController.listStoryTopic.value) {
        if (itemA == itemB.id) {
          lstTopicName.add(itemB.title);
        }
      }
    }
    return lstTopicName;
  }

  Future<void> _listenStory() async {
    await storyController.updateListenCount(
        context, storyController.currentStory.value.id);
    setState(() {
      cubit.listenCount = storyController.currentStory.value.listenCount;
    });
    context.router.pushNamed(Routes.storyplayer);
  }

  @override
  void initState() {
    super.initState();
    loadingController.showLoading();
    setDimension();
    _setStoryInformation(storyController.currentStory.value,
        userStoryController.currentUserStory.value);
    loadingController.hideLoading();
  }
}
