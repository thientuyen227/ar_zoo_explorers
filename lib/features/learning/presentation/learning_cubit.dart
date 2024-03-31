import 'package:ar_zoo_explorers/features/learning/presentation/learning_state.dart';
import 'package:injectable/injectable.dart';

import '../../../base/base_cubit.dart';

@injectable
class LearningCubit extends BaseCubit<LearningState> {
  LearningCubit() : super(LearningState());
}
