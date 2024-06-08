import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/presentation/vocabulary_detail_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class VocabularyDetailCubit extends BaseCubit<VocabularyDetailState> {
  VocabularyDetailCubit() : super(VocabularyDetailState());
  void init({required String categoryId}) async {
    final vocabularyController = VocabularyController.findOrInitialize;
    showLoading();
    List<VocabularyEntity>? vocabularyEntities =
        await vocabularyController.getAllVocabularys();
    emit(state.copyWith(
        vocabularies: vocabularyEntities
            ?.where((element) => element.categoryId == categoryId)
            .toList()));
    hideLoading();
  }
}
