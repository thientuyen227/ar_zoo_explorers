import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginState());
}
