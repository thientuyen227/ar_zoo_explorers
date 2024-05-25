import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/base-model/button_object.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:get/get.dart';

import '../../../app/app/app_state.dart';

class HomeState {
  final PageStatus pageStatus;

  double height;
  double width;

  String urlAvatarUser;

  int currentAdsPage;

  List<ButtonObject> listAnimalCategory;

  HomeState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
    this.urlAvatarUser = AppIcons.icDefaultUser,
    this.currentAdsPage = 0,
    this.listAnimalCategory = const [],
  });

  HomeState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    String? urlAvatarUser,
    int? currentAdsPage,
    List<ButtonObject>? listAnimalCategory,
  }) {
    return HomeState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      urlAvatarUser: urlAvatarUser ?? this.urlAvatarUser,
      currentAdsPage: currentAdsPage ?? this.currentAdsPage,
      listAnimalCategory: listAnimalCategory ?? this.listAnimalCategory,
    );
  }

  setAttributes({
    PageStatus? pageStatus,
    double? height,
    double? width,
    String? urlAvatarUser,
    int? currentAdsPage,
    List<ButtonObject>? listAnimalCategory,
  }) async {
    this.pageStatus ?? this.pageStatus;
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.urlAvatarUser = urlAvatarUser ?? this.urlAvatarUser;
    this.currentAdsPage = currentAdsPage ?? this.currentAdsPage;
    this.listAnimalCategory = listAnimalCategory ?? this.listAnimalCategory;
  }

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search",
      hint_text: LanguageKeys.search.tr,
      icon_suffix: AppIcons.icSearch);

  List<String> lstAdvertisement = [
    AppImages.imgAdvertisement,
    AppImages.imgAds1,
    AppImages.imgAds2,
  ];
}
