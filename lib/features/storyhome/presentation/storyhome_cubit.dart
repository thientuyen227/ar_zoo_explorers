import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';
import 'package:ar_zoo_explorers/features/base-model/button_object.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/features/storyhome/model/topic_button_object.dart';
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryHomeCubit extends BaseCubit<StoryHomeState> {
  StoryHomeCubit() : super(StoryHomeState());

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search", hint_text: "search", icon_suffix: AppIcons.icSearch);

  double HEIGHT = 0;
  double WIDTH = 0;

  List<ButtonObject> lstRecommend = [
    ButtonObject(title: "Rùa và thỏ", icon: AppImages.imgRuaVaTho, views: 259),
    ButtonObject(
        title: "Bác voi tốt bụng",
        icon: AppImages.imgBacVoiTotBung,
        views: 269),
    ButtonObject(
        title: "Chú gà trống kiêu căng",
        icon: AppImages.imgChuGaTrongKieuCang,
        views: 359),
    ButtonObject(
        title: "Dế mèn phiêu lưu ký",
        icon: AppImages.imgDeMenPhieuLuuKy,
        views: 309),
    ButtonObject(
        title: "Chú chó Hachiko",
        icon: AppImages.imgChuChoHachiko,
        views: 1259),
    ButtonObject(
        title: "Vịt con xấu xí", icon: AppImages.imgVitConXauXi, views: 299),
  ];

  List<TopicButtonObject> lstTopic = [
    // ButtonObject(title: "Cổ tích", icon: AppImages.imgCoTich),
    // ButtonObject(title: "Đạo đức", icon: AppImages.imgDaoDuc),
    // ButtonObject(title: "Ngụ ngôn", icon: AppImages.imgNguNgon),
    // ButtonObject(title: "Truyền thuyết", icon: AppImages.imgTruyenThuyet),
    // ButtonObject(title: "Truyện cười", icon: AppImages.imgTruyenCuoi),
  ];

  String nameCustom(String fullname, int index) {
    List<String> parts = fullname.split(" ");
    return customContent(parts.last, index);
  }

  String customContent(String content, int index) {
    String respond = content;
    if (content.length > index) {
      respond = '${content.substring(0, (index - 3))}...';
    }
    return respond;
  }

  void getAllTopics(List<StoryTopicEntity> topics) {
    StoryTopicEntity tmp = StoryTopicEntity(
        id: '', title: '', name: ',', imageUrl: '', status: true);
    for (var item in topics) {
      if (item.name != 'otherstories') {
        lstTopic.add(TopicButtonObject(
            id: item.id,
            name: item.name,
            title: item.title,
            imageUrl: item.imageUrl));
      } else {
        tmp = item;
      }
    }
    if (tmp.id != '') {
      lstTopic.add(TopicButtonObject(
          id: tmp.id,
          name: tmp.name,
          title: tmp.title,
          imageUrl: tmp.imageUrl));
    }
  }
}
