import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/learning_category_controller.dart';
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleWordCubit extends BaseCubit<PuzzleWordState> {
  PuzzleWordCubit() : super(PuzzleWordState());
  void init() async {
    final leaningCategoryController =
        LearningCategoryController.findOrInitialize;
    showLoading();
    emit(state.copyWith(
        learningcategories:
            await leaningCategoryController.getAllLearningCategorys()));
    hideLoading();
  }
}
