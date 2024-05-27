import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleCubit extends BaseCubit<PuzzleState> {
  PuzzleCubit() : super(PuzzleState());
  void init() async {
    final questionController = QuestionController.findOrInitialize;
    showLoading();
    emit(state.copyWith(
        questionEntities: await questionController.getAllQuestions()));
    hideLoading();
  }
}
