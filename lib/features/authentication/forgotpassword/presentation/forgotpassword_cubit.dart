import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/forgotpassword/presentation/forgotpassword_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState());
}
