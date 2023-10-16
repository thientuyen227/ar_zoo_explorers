import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';

@injectable
class TermOfServiceCubit extends BaseCubit<TermOfServiceState> {
  TermOfServiceCubit() : super(TermOfServiceState());
}
