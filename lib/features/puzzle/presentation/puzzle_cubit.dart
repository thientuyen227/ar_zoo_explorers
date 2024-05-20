import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleCubit extends BaseCubit<PuzzleState> {
  PuzzleCubit() : super(PuzzleState());
}
