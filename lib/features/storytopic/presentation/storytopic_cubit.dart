import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/storytopic/presentation/storytopic_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryTopicCubit extends BaseCubit<StoryTopicState> {
  StoryTopicCubit() : super(StoryTopicState());
}
