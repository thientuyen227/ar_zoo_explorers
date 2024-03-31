import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/language/change_language_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangLanguageCubit extends BaseCubit<ChangLanguageState> {
  ChangLanguageCubit() : super(ChangLanguageState());
}
