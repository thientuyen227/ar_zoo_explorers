import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/learning_category_controller.dart';
import 'package:ar_zoo_explorers/features/vocabulary/presentation/vocabulary_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class VocabularyCubit extends BaseCubit<VocabularyState> {
  VocabularyCubit() : super(VocabularyState());

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
      learningcategories:
          await leaningCategoryController.getAllLearningCategorys(context),
      height: mediaSize.height,
      width: mediaSize.width,
    ));
    hideLoading();
  }
}
