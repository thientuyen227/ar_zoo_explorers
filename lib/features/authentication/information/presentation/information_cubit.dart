import 'package:ar_zoo_explorers/features/authentication/information/presentation/information_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';

@injectable
class InformationCubit extends BaseCubit<InformationState> {
  InformationCubit() : super(InformationState());
}
