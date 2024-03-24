import 'package:injectable/injectable.dart';

import '../../../base/base_cubit.dart';
import 'languageselection_state.dart';

@injectable
class LanguageSelectionCubit extends BaseCubit<LanguageSelectionState> {
  LanguageSelectionCubit() : super(LanguageSelectionState());

  double WIDTH = 0;
  double HEIGHT = 0;
}
