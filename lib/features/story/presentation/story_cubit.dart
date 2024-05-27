import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/story/presentation/story_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryCubit extends BaseCubit<StoryState> {
  StoryCubit() : super(StoryState());

  double WIDTH = 0;
  double HEIGHT = 0;

  int selectedIndex = 0;

  List<Map<String, String>> lstBottomItem = [
    {'name': LanguageKeys.explore.tr, 'url': AppIcons.icHome64},
    {'name': LanguageKeys.favorite.tr, 'url': AppIcons.icHeart64},
    {'name': LanguageKeys.search.tr, 'url': AppIcons.icMagnifyingGlass64},
    {'name': LanguageKeys.listening.tr, 'url': AppIcons.icPlay64}
  ];
}
