import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storyfavorite/presentation/storyfavorite_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryFavoriteCubit extends BaseCubit<StoryFavoriteState> {
  StoryFavoriteCubit() : super(StoryFavoriteState());

  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  // List<StoryButtonObject> listStory = [];

  Future<void> init(BuildContext context) async {
    showLoading();
    await _getUserStory(context);
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        listStory: await _setStoryButtons(
          storyController.listStory.value,
          userStoryController.listFavoriteUserStory.value,
          storyTopicController.listStoryTopic.value,
        )));
    // await state.setAttributes(
    //   height: mediaSize.height,
    //   width: mediaSize.width,
    //   listStory: await _setStoryButtons(
    //     storyController.listStory.value,
    //     userStoryController.listFavoriteUserStory.value,
    //     storyTopicController.listStoryTopic.value,
    //   ),
    // );
    print("Cubit.Init() : Get data");
    hideLoading();
  }

  Future<void> setCurrentStory(BuildContext context, String storyId) async {
    await storyController.getStory(context, id: storyId);
    await userStoryController.createOrGetUserStory(context,
        userId: controller.currentUser.value.id, storyId: storyId);
  }

  Future<List<StoryButtonObject>> _setStoryButtons(
    List<StoryEntity> lstStory,
    List<UserStoryEntity> lstUS,
    List<StoryTopicEntity> lstTopic,
  ) async {
    List<StoryButtonObject> stories = await _setStories(lstStory, lstUS);

    Map<String, StoryTopicEntity> topicMap = {};
    for (var topic in lstTopic) {
      topicMap[topic.id] = topic;
    }

    for (var story in stories) {
      List<String> topicNames = [];
      for (var topicId in story.topic) {
        var topic = topicMap[topicId];
        if (topic != null) {
          topicNames.add(topic.title);
        }
      }

      story.topic = [_getTopics(topicNames)];
    }
    return stories;
  }

  Future<List<StoryButtonObject>> _setStories(
      List<StoryEntity> lstStory, List<UserStoryEntity> lstUS) async {
    List<StoryButtonObject> stories = [];
    for (var itemA in lstUS) {
      for (var itemB in lstStory) {
        if (itemA.storyId == itemB.id) {
          stories.add(StoryButtonObject(
            id: itemB.id,
            name: itemB.title,
            avatar: itemB.avatar,
            author: itemB.author,
            reader: itemB.reader,
            duration: Duration(seconds: itemB.duration),
            topic: itemB.topicId,
            isCompleted: itemA.isCompleted,
          ));
        }
      }
    }
    return stories;
  }

  Future<void> _getUserStory(BuildContext context) async {
    await userStoryController.getFavoriteUserStory(context,
        userId: controller.currentUser.value.id, isFavorited: true);
  }

  String _getTopics(List<String> lstTopicName) {
    String topics = lstTopicName[0];
    for (int i = 1; i < lstTopicName.length; i++) {
      topics = "$topics, ${lstTopicName[i]}";
    }
    return topics;
  }
}
