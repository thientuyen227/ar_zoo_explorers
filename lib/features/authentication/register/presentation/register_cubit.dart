import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';

@injectable
class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit() : super(RegisterState());
}
