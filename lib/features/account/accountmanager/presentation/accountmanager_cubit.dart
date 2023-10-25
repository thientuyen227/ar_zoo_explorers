import 'package:ar_zoo_explorers/features/account/accountmanager/presentation/accountmanager_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';

@injectable
class AccountManagerCubit extends BaseCubit<AccountManagerState> {
  AccountManagerCubit() : super(AccountManagerState());
}
