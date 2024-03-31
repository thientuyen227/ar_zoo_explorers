import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/vocabulary/vocabulary_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class VocabularyCubit extends BaseCubit<VocabularyState> {
  VocabularyCubit() : super(VocabularyState());
}
