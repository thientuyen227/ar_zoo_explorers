import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../base/base_cubit.dart';
import '../model/provincial_name.dart';

@injectable
class UserInformationCubit extends BaseCubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationState());

  final controller = AuthController.findOrInitialize;

  Future<void> init() async {
    showLoading();
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
      dtBirthday: dateFormat.parse(controller.currentUser.value.birth),
    ));

    await setValueAddress(controller.currentUser.value.address);
    print("Cubit.Init() : Get data");
    hideLoading();
  }

  Future<void> changeDtBirthday(DateTime dt) async {
    emit(state.copyWith(dtBirthday: dt));
  }

  Future<void> changeAddress(String address) async {
    // emit(state.copyWith(address: address));
    state.setAttributes(address: address);
  }

  Future<void> changeProvincial(String provincial) async {
    // emit(state.copyWith(provincial: provincial));
    state.setAttributes(provincial: provincial);
  }

  Future<void> setValueAddress(String value) async {
    List<String> values = value.split(', ');
    String tempAdd = '';
    if (Provincial().names.contains(values[values.length - 1].trim())) {
      await changeProvincial(values[values.length - 1].trim());
      // state.provincial = values[values.length - 1].trim();
    }
    tempAdd = values[0];
    for (int i = 1; i < values.length - 1; i++) {
      tempAdd = "$tempAdd, ${values[i]}";
    }
    await changeAddress(tempAdd);
  }

  void setAddress(String value) {
    List<String> values = value.split(', ');
    if (Provincial().names.contains(values[values.length - 1].trim())) {
      state.provincial = values[values.length - 1].trim();
    }
    state.address = values[0];
    for (int i = 1; i < values.length - 1; i++) {
      state.address = "${state.address}, ${values[i]}";
    }
  }

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String userAvatar = "";
  String userBackground = "";
  String provider = "";
  String gender = "male";

  // Future<void> setBirthday(String? date) async {
  //   if (date != "" && date != null) {
  //     await changeDtBirthday(dateFormat.parse(date));
  //   }
  // }

  void setUserAvatar(String? url) {
    if (url != "" && url != null) {
      userAvatar = url;
    }
  }

  void setUserBackground(String? url) {
    if (url != "" && url != null) {
      userBackground = url;
    }
  }

  void setProvider(String? url) {
    if (url != "" && url != null) {
      provider = url;
    }
  }

  void setGender(String userGender) {
    if (userGender == 'female') {
      gender = userGender;
    }
  }

  String getBirthday() {
    return dateFormat.format(state.dtBirthday);
  }

  String avatarName(String fullname) {
    String name = "";
    List<String> values = fullname.split(' ');
    for (int i = 0; i < values.length; i++) {
      name = "$name${values[i]}";
    }
    name = name +
        DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString() +
        DateTime.now().microsecond.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().hour.toString();
    return name;
  }

  String? onCheckPhoneNumber(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length < 10) {
        return LanguageKeys.msg_phoneNumberIncorrect.tr;
      }
    }
    return null;
  }

  String? onCheckFullname(String? value) {
    if (value != null && value.isNotEmpty) {
      if (_containsSpecialCharacters(value)) {
        return LanguageKeys.msg_fullNameIncorrect.tr;
      }
    }
    return null;
  }

  bool _containsSpecialCharacters(String input) {
    // Regular expression to match special characters
    final RegExp specialCharacters = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return specialCharacters.hasMatch(input);
  }
}
