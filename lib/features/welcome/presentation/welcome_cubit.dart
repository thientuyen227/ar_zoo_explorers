import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_state.dart';
import 'package:injectable/injectable.dart';

import '../../../base/base_cubit.dart';

@injectable
class WelcomeCubit extends BaseCubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeState());

  double WIDTH = 0;
  double HEIGHT = 0;
}
