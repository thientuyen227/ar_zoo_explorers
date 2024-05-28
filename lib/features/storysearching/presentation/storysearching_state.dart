import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';

class StorySearchingState {
  final PageStatus pageStatus;

  double width;
  double height;

  bool searchStatus;
  String txtSearch;

  List<StoryButtonObject> listSearchStory;
  List<StoryButtonObject> listFullStory;

  StorySearchingState({
    this.pageStatus = PageStatus.loading,
    this.width = 0,
    this.height = 0,
    this.searchStatus = false,
    this.txtSearch = '',
    this.listFullStory = const [],
    this.listSearchStory = const [],
  });

  StorySearchingState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    bool? searchStatus,
    String? txtSearch,
    List<StoryButtonObject>? listSearchStory,
    List<StoryButtonObject>? listFullStory,
  }) {
    return StorySearchingState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      searchStatus: searchStatus ?? this.searchStatus,
      txtSearch: txtSearch ?? this.txtSearch,
      listSearchStory: listSearchStory ?? this.listSearchStory,
      listFullStory: listFullStory ?? this.listFullStory,
    );
  }

  setAttributes({
    double? height,
    double? width,
    bool? searchStatus,
    String? txtSearch,
    List<StoryButtonObject>? listSearchStory,
    List<StoryButtonObject>? listFullStory,
  }) async {
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.searchStatus = searchStatus ?? this.searchStatus;
    this.txtSearch = txtSearch ?? this.txtSearch;
    this.listFullStory = listFullStory ?? this.listFullStory;
    this.listSearchStory = listSearchStory ?? this.listSearchStory;
  }
}
