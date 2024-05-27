import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';

class StoryFavoriteState {
  final PageStatus pageStatus;

  double height;
  double width;

  List<StoryButtonObject> listStory;

  StoryFavoriteState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
    this.listStory = const [],
  });

  StoryFavoriteState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    List<StoryButtonObject>? listStory,
  }) {
    return StoryFavoriteState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      listStory: listStory ?? this.listStory,
    );
  }

  setAttributes({
    double? height,
    double? width,
    List<StoryButtonObject>? listStory,
  }) async {
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.listStory = listStory ?? this.listStory;
  }
}
