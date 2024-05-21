import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/domain/entities/user_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:get/get.dart';

class StoryHomeState {
  final PageStatus pageStatus;
  double height;
  double width;

  UserEntity user;

  List<StoryButtonObject> lstRecommend;

  StoryHomeState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
    UserEntity? user,
    this.lstRecommend = const [],
  }) : user = UserEntity(
            address: '',
            id: '',
            avatarUrl: '',
            fullname: '',
            email: '',
            phone: '',
            birth: '',
            provider: '',
            gender: '',
            role: '',
            status: true);

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search",
      hint_text:
          "${LanguageKeys.example.tr} : ${LanguageKeys.story_examples_1.tr},...",
      icon_suffix: AppIcons.icSearch);

  StoryHomeState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    UserEntity? user,
    List<StoryButtonObject>? lstRecommend,
  }) {
    return StoryHomeState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      user: user ?? this.user,
      lstRecommend: lstRecommend ?? this.lstRecommend,
    );
  }

  setAttributes({
    PageStatus? pageStatus,
    double? height,
    double? width,
    UserEntity? user,
    List<StoryButtonObject>? lstRecommend,
  }) async {
    this.pageStatus ?? this.pageStatus;
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.user = user ?? this.user;
    this.lstRecommend = lstRecommend ?? this.lstRecommend;
  }
}
