import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/story/presentation/story_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryCubit extends BaseCubit<StoryState> {
  StoryCubit() : super(StoryState());

  double WIDTH = 0;
  double HEIGHT = 0;

  int selectedIndex = 0;

  List<Map<String, String>> lstBottomItem = [
    {'name': 'Trang chủ', 'url': AppIcons.icHome64},
    {'name': 'Ưa thích', 'url': AppIcons.icHeart64},
    {'name': 'Tìm kiếm', 'url': AppIcons.icMagnifyingGlass64},
    {'name': 'Đang nghe', 'url': AppIcons.icPlay64}
  ];
}
