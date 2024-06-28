import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/learning_category_controller.dart';
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_state.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleWordCubit extends BaseCubit<PuzzleWordState> {
  PuzzleWordCubit() : super(PuzzleWordState());
  Future<void> init(
    BuildContext context,
  ) async {
    final leaningCategoryController =
        LearningCategoryController.findOrInitialize;
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    showLoading();
    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        learningcategories:
            await leaningCategoryController.getAllLearningCategorys(context)));
    hideLoading();
  }
}
