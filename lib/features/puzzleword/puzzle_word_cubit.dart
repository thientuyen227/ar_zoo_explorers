import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/topic_entity.dart';
import 'package:ar_zoo_explorers/features/puzzleword/puzzle_word_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleWordCubit extends BaseCubit<PuzzleWordState> {
  PuzzleWordCubit() : super(PuzzleWordState());
  List<TopicEntity> topics = [
    TopicEntity(
        title: LanguageKeys.animals.tr, image: AppImages.imgFox, level: "Easy"),
    TopicEntity(
        title: LanguageKeys.fruit.tr,
        image: AppImages.imgFruits,
        level: "Easy"),
    TopicEntity(
        title: LanguageKeys.toys.tr, image: AppImages.imgToys, level: "Easy"),
    TopicEntity(
        title: LanguageKeys.family.tr,
        image: AppImages.imgFamily,
        level: "Easy"),
  ];
}
