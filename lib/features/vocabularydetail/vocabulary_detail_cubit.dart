import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/vocabulary_detail_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class VocabularyDetailCubit extends BaseCubit<VocabularyDetailState> {
  VocabularyDetailCubit() : super(VocabularyDetailState());
}
