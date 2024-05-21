import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storyhome/model/topic_button_object.dart';
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryHomeCubit extends BaseCubit<StoryHomeState> {
  StoryHomeCubit() : super(StoryHomeState());

  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  Future<void> init(BuildContext context) async {
    showLoading();
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    await controller.getCurrentUser(context);
    await state.setAttributes(
        height: mediaSize.height,
        width: mediaSize.width,
        user: controller.currentUser.value,
        lstRecommend: await getStoriesByReleaseDate());
    print("init cubit");
    hideLoading();
  }

  Future<List<StoryButtonObject>> getStoriesByReleaseDate() async {
    await storyController.getStoriesByReleaseDate(null, true);
    return await getRecommend(storyController.listStory.value.sublist(0, 5));
  }

  Future<List<StoryButtonObject>> getRecommend(
      List<StoryEntity> stories) async {
    List<StoryButtonObject> items = [];
    for (var item in stories) {
      items.add(StoryButtonObject(
          id: item.id,
          name: item.title,
          avatar: item.avatar,
          topic: item.topicId));
    }
    return items;
  }

  List<TopicButtonObject> lstTopic = [];

  String nameCustom(String fullname, int index) {
    List<String> parts = fullname.split(" ");
    return customContent(parts.last, index);
  }

  String customContent(String content, int index) {
    String respond = content;
    if (content.length > index) {
      respond = '${content.substring(0, (index - 3))}...';
    }
    return respond;
  }

  void getAllTopics(List<StoryTopicEntity> topics) {
    StoryTopicEntity tmp = StoryTopicEntity(
        id: '', title: '', name: ',', imageUrl: '', status: true);
    for (var item in topics) {
      if (item.name != 'otherstories') {
        lstTopic.add(TopicButtonObject(
            id: item.id,
            name: item.name,
            title: item.title,
            imageUrl: item.imageUrl));
      } else {
        tmp = item;
      }
    }
    if (tmp.id != '') {
      lstTopic.add(TopicButtonObject(
          id: tmp.id,
          name: tmp.name,
          title: tmp.title,
          imageUrl: tmp.imageUrl));
    }
  }
}
