import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/presentation/vocabulary_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class VocabularyDetailCubit extends BaseCubit<VocabularyDetailState> {
  VocabularyDetailCubit() : super(VocabularyDetailState());
  Future<void> init(
      {required BuildContext context, required String categoryId}) async {
    final vocabularyController = VocabularyController.findOrInitialize;
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    showLoading();
    List<VocabularyEntity>? vocabularyEntities =
        await vocabularyController.getAllVocabularys(context);
    emit(state.copyWith(
        vocabularies: vocabularyEntities
            ?.where((element) => element.categoryId == categoryId)
            .toList(),
        height: mediaSize.height,
        width: mediaSize.width));
    hideLoading();
  }
}
