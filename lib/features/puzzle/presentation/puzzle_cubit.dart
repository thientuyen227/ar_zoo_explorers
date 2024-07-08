import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/learning_category_controller.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_state.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleCubit extends BaseCubit<PuzzleState> {
  PuzzleCubit() : super(PuzzleState());
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
