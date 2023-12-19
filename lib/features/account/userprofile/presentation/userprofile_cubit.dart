import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';

@injectable
class UserProfileCubit extends BaseCubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileState());
  String userAvatar = "";

  void setUserAvatar(String? url) {
    if (url != "" && url != null) {
      userAvatar = url;
    }
  }

  String getGender(String gender) {
    if (gender == '') {
      return "Chưa cập nhật";
    } else if (gender == 'male') {
      return "Nam";
    } else {
      return "Nữ";
    }
  }
}
