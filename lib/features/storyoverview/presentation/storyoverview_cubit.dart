import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryOverviewCubit extends BaseCubit<StoryOverviewState> {
  StoryOverviewCubit() : super(StoryOverviewState());

  double HEIGHT = 0;
  double WIDTH = 0;
  String name = "";
  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/stories%2Fimg_default_book.jpg?alt=media&token=8dec4ea0-7fb6-436b-9b09-0efddf866fb6";
  String author = "";
  String reader = "";
  int listenCount = 0;
  Duration duration = const Duration(seconds: 0, minutes: 0, hours: 0);
  String topic = "";
  String overView = "";
  bool isFavorite = false;

  void setStoryInformation(StoryEntity storyEntity, UserStoryEntity usEntity,
      List<String> lstTopicName) {
    name = storyEntity.title;
    avatar = storyEntity.avatar;
    author = storyEntity.author;
    reader = storyEntity.reader;
    listenCount = storyEntity.listenCount;
    duration = Duration(seconds: storyEntity.duration);
    topic = getTopics(lstTopicName);
    overView = storyEntity.overView;
    listenCount = storyEntity.listenCount;
    isFavorite = usEntity.isFavorited;
  }

  String getTopics(List<String> lstTopicName) {
    String topics = lstTopicName[0];
    for (int i = 1; i < lstTopicName.length; i++) {
      topics = "$topics, ${lstTopicName[i]}";
    }
    return topics;
  }

  void isLoved() {
    isFavorite = !isFavorite;
  }
}
