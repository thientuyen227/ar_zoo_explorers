import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storyhome/model/topic_button_object.dart';
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryHomeCubit extends BaseCubit<StoryHomeState> {
  StoryHomeCubit() : super(StoryHomeState());

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search", hint_text: "search", icon_suffix: AppIcons.icSearch);

  double HEIGHT = 0;
  double WIDTH = 0;

  List<StoryButtonObject> lstRecommend = [];

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

  void getRecommendStories(List<StoryEntity> stories) {
    for (var item in stories) {
      lstRecommend.add(StoryButtonObject(
          id: item.id,
          name: item.title,
          avatar: item.avatar,
          topic: item.topicId));
    }
  }
}
