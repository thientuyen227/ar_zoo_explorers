import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storysearching/presentation/storysearching_state.dart';
import 'package:injectable/injectable.dart';
import 'package:remove_diacritic/remove_diacritic.dart';

@injectable
class StorySearchingCubit extends BaseCubit<StorySearchingState> {
  StorySearchingCubit() : super(StorySearchingState());

  bool searchStatus = false;

  List<StoryButtonObject> listSearchStory = [];
  List<StoryButtonObject> listFullStory = [];

  double WIDTH = 0;
  double HEIGHT = 0;

  String txtSearch = "";

  void onSearch(String searchValue) {
    listSearchStory = [];
    for (int i = 0; i < listFullStory.length; i++) {
      if (convertDiacritics(listFullStory[i].name)
          .contains(convertDiacritics(searchValue))) {
        listSearchStory.add(StoryButtonObject(
            id: listFullStory[i].id,
            name: listFullStory[i].name,
            avatar: listFullStory[i].avatar,
            author: listFullStory[i].author,
            reader: listFullStory[i].reader,
            topic: listFullStory[i].topic,
            duration: listFullStory[i].duration));
      }
    }
  }

  void getAllStories(List<StoryEntity> lstStory,
      List<StoryTopicEntity> lstTopic, bool status) {
    listFullStory = [];
    listSearchStory = [];

    setListStory(lstStory);

    Map<String, StoryTopicEntity> topicMap = {};
    for (var topic in lstTopic) {
      topicMap[topic.id] = topic;
    }

    for (var story in listFullStory) {
      List<String> topicNames = [];
      for (var topicId in story.topic) {
        var topic = topicMap[topicId];
        if (topic != null) {
          topicNames.add(topic.title);
        }
      }
      story.topic = [getTopics(topicNames)];
    }
    if (searchStatus) {
      onSearch(txtSearch);
    }
  }

  void setListStory(List<StoryEntity> lstStory) {
    for (var itemB in lstStory) {
      var tmpObject = StoryButtonObject(
        id: itemB.id,
        name: itemB.title,
        avatar: itemB.avatar,
        author: itemB.author,
        reader: itemB.reader,
        listenCount: itemB.listenCount,
        duration: Duration(seconds: itemB.duration),
        timestamp: Duration(seconds: itemB.duration),
        topic: itemB.topicId,
      );
      listFullStory.add(tmpObject);
    }
  }

  String getTopics(List<String> lstTopicName) {
    String topics = lstTopicName[0];
    for (int i = 1; i < lstTopicName.length; i++) {
      topics = "$topics, ${lstTopicName[i]}";
    }
    return topics;
  }

  String convertDiacritics(String input) {
    print(input);
    print(input.trim().toLowerCase());
    return removeDiacritics(input.trim().toLowerCase());
  }
}
