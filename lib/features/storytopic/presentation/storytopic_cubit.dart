import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storytopic/presentation/storytopic_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryTopicCubit extends BaseCubit<StoryTopicState> {
  StoryTopicCubit() : super(StoryTopicState());

  double HEIGHT = 0;
  double WIDTH = 0;

  List<StoryButtonObject> listStory = [];
  final languageCode = Get.locale?.languageCode;

  void setStory(List<StoryEntity> storyEntity, StoryTopicEntity stEntity) {
    for (var itemA in storyEntity) {
      for (var itemB in itemA.topicId) {
        if (stEntity.id == itemB) {
          listStory.add(StoryButtonObject(
            id: itemA.id,
            name: itemA.title,
            avatar: itemA.avatar,
            author: itemA.author,
            reader: itemA.reader,
            duration: Duration(seconds: itemA.duration),
            topic: [stEntity.title[languageCode]!],
          ));
        }
      }
    }
  }
}
