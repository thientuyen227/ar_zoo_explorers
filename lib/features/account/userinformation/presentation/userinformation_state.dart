import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/app/app_state.dart';

class UserInformationState {
  final PageStatus pageStatus;
  double height;
  double width;
  String userAvatar;
  DateTime dtBirthday;
  String address;
  String provincial;
  String provider;
  String gender;

  UserInformationState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
    this.userAvatar = '',
    DateTime? dtBirthday,
    this.address = "",
    this.provincial = "An Giang",
    this.provider = "",
    this.gender = "male",
  }) : dtBirthday = dtBirthday ?? DateTime.now();

  UserInformationState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    DateTime? dtBirthday,
    String? address,
    String? provincial,
    String? userAvatar,
    String? provider,
    String? gender,
  }) {
    return UserInformationState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      dtBirthday: dtBirthday ?? this.dtBirthday,
      address: address ?? this.address,
      provincial: provincial ?? this.provincial,
      userAvatar: userAvatar ?? this.userAvatar,
      gender: gender ?? this.gender,
      provider: provider ?? this.provider,
    );
  }

  setAttributes({
    double? height,
    double? width,
    DateTime? dtBirthday,
    String? address,
    String? provincial,
    String? userAvatar,
    String? provider,
    String? gender,
  }) async {
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.dtBirthday = dtBirthday ?? this.dtBirthday;
    this.address = address ?? this.address;
    this.provincial = provincial ?? this.provincial;
    this.userAvatar = userAvatar ?? this.userAvatar;
    this.gender = gender ?? this.gender;
    this.provider = provider ?? this.provider;
  }

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  List<FormBuilderTextFieldModel> ListFormItem = [
    FormBuilderTextFieldModel(
        name: "fullname",
        hint_text: "Full name",
        icon_prefix: AppIcons.icUser,
        TIT: TextInputType.none),
    FormBuilderTextFieldModel(
        name: "email",
        hint_text: "Email Address",
        icon_prefix: AppIcons.icMail,
        TIT: TextInputType.emailAddress),
    FormBuilderTextFieldModel(
        name: "phone",
        hint_text: "Phone Number",
        icon_prefix: AppIcons.icPhone,
        TIT: TextInputType.phone),
    FormBuilderTextFieldModel(
        name: "address",
        hint_text: "Address",
        icon_prefix: AppIcons.icAddress,
        TIT: TextInputType.text),
  ];
}
