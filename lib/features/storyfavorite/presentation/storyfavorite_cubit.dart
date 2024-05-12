import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storyfavorite/presentation/storyfavorite_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryFavoriteCubit extends BaseCubit<StoryFavoriteState> {
  StoryFavoriteCubit() : super(StoryFavoriteState());

  double WIDTH = 0;
  double HEIGHT = 0;

  List<StoryButtonObject> listStory = [];

  void setInformations(List<StoryEntity> lstStory, List<UserStoryEntity> lstUS,
      List<StoryTopicEntity> lstTopic) {
    listStory = [];
    setListStory(lstStory, lstUS);

    Map<String, StoryTopicEntity> topicMap = {};
    for (var topic in lstTopic) {
      topicMap[topic.id] = topic;
    }

    for (var story in listStory) {
      List<String> topicNames = [];
      for (var topicId in story.topic) {
        var topic = topicMap[topicId];
        if (topic != null) {
          topicNames.add(topic.title);
        }
      }

      story.topic = [getTopics(topicNames)];
    }
  }

  void setListStory(List<StoryEntity> lstStory, List<UserStoryEntity> lstUS) {
    for (var itemA in lstUS) {
      for (var itemB in lstStory) {
        if (itemA.storyId == itemB.id) {
          listStory.add(StoryButtonObject(
            id: itemB.id,
            name: itemB.title,
            avatar: itemB.avatar,
            author: itemB.author,
            reader: itemB.reader,
            duration: Duration(seconds: itemB.duration),
            topic: itemB.topicId,
          ));
        }
      }
    }
  }

  String getTopics(List<String> lstTopicName) {
    String topics = lstTopicName[0];
    for (int i = 1; i < lstTopicName.length; i++) {
      topics = "$topics, ${lstTopicName[i]}";
    }
    return topics;
  }
}
