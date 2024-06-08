import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storysearching/presentation/storysearching_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:remove_diacritic/remove_diacritic.dart';

@injectable
class StorySearchingCubit extends BaseCubit<StorySearchingState> {
  StorySearchingCubit() : super(StorySearchingState());

  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  Future<void> init(BuildContext context) async {
    showLoading();
    await storyController.getAllStories(context);
    await storyTopicController.getAllStoryTopics(context);

    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    List<StoryButtonObject> lstFull = await _setAllStories(
        storyController.listStory.value,
        storyTopicController.listStoryTopic.value);

    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
      searchStatus: storyController.searchStatus.value,
      txtSearch: storyController.txtSearch.value,
      listFullStory: lstFull,
    ));

    // await state.setAttributes(
    //     height: mediaSize.height,
    //     width: mediaSize.width,
    //     searchStatus: storyController.searchStatus.value,
    //     txtSearch: storyController.txtSearch.value,
    //     listFullStory: lstFull,);

    List<StoryButtonObject> lstSearch = storyController.searchStatus.value
        ? await _setSearchStories(storyController.txtSearch.value)
        : [];

    emit(state.copyWith(listSearchStory: lstSearch));

    await state.setAttributes(listSearchStory: lstSearch);
    // print("Cubit.Init() : Get data, ${storyController.searchStatus.value}");
    hideLoading();
  }

  Future<void> _setSearchWord(String word) async {
    showLoading();
    await state.setAttributes(txtSearch: word, searchStatus: true);
    hideLoading();
  }

  Future<void> onSearch(BuildContext context, String searchValue) async {
    showLoading();
    await storyController.updateSearching(context, text: searchValue);
    await _setSearchWord(searchValue);
    List<StoryButtonObject> stories = await _setSearchStories(searchValue);
    await state.setAttributes(listSearchStory: stories);
    hideLoading();
  }

  Future<List<StoryButtonObject>> _setSearchStories(String searchValue) async {
    List<StoryButtonObject> stories = [];
    for (int i = 0; i < state.listFullStory.length; i++) {
      if (convertDiacritics(state.listFullStory[i].name)
          .contains(convertDiacritics(searchValue))) {
        stories.add(StoryButtonObject(
            id: state.listFullStory[i].id,
            name: state.listFullStory[i].name,
            avatar: state.listFullStory[i].avatar,
            author: state.listFullStory[i].author,
            reader: state.listFullStory[i].reader,
            topic: state.listFullStory[i].topic,
            duration: state.listFullStory[i].duration));
      }
    }
    return stories;
  }

  Future<List<StoryButtonObject>> _setAllStories(
      List<StoryEntity> lstStory, List<StoryTopicEntity> lstTopic) async {
    List<StoryButtonObject> stories = [];
    for (var item in lstStory) {
      var tmpObject = StoryButtonObject(
        id: item.id,
        name: item.title,
        avatar: item.avatar,
        author: item.author,
        reader: item.reader,
        listenCount: item.listenCount,
        duration: Duration(seconds: item.duration),
        timestamp: Duration(seconds: item.duration),
        topic: item.topicId,
      );
      stories.add(tmpObject);
    }

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
      story.topic = [getTopics(topicNames)];
    }
    return stories;
  }

  Future<void> getStory(BuildContext context, String id) async {
    await storyController.getStory(context, id: id);
  }

  Future<void> createOrGetUserStory(BuildContext context, String id) async {
    await userStoryController.createOrGetUserStory(context,
        userId: controller.currentUser.value.id, storyId: id);
  }

  String getTopics(List<String> lstTopicName) {
    String topics = lstTopicName[0];
    for (int i = 1; i < lstTopicName.length; i++) {
      topics = "$topics, ${lstTopicName[i]}";
    }
    return topics;
  }

  String convertDiacritics(String input) {
    // print(input);
    // print(input.trim().toLowerCase());
    return removeDiacritics(input.trim().toLowerCase());
  }
}
