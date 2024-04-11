import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzleworddetail/puzzle_word_detail_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleWordDetailCubit extends BaseCubit<PuzzleWordDetailState> {
  PuzzleWordDetailCubit() : super(PuzzleWordDetailState());
}
