import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';

@injectable
class UserProfileCubit extends BaseCubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileState());
  double HEIGHT = 0;
  double WIDTH = 0;

  String userAvatar = "";

  Future<void> init(BuildContext context) async {
    showLoading();
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
    ));

    print("Cubit.Init() : Get data");
    hideLoading();
  }

  void setUserAvatar(String? url) {
    if (url != "" && url != null) {
      userAvatar = url;
    }
  }

  String getGender(String gender) {
    if (gender == '') {
      return "Not updated";
    } else if (gender == 'male') {
      return "Male";
    } else {
      return "Female";
    }
  }
}
