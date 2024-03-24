import 'package:ar_zoo_explorers/features/story/presentation/story_state.dart';
import 'package:injectable/injectable.dart';

import '../../../app/theme/icons.dart';
import '../../../base/base_cubit.dart';
import '../../base-model/button_object.dart';
import '../../base-model/form_builder_text_field_model.dart';

@injectable
class StoryCubit extends BaseCubit<StoryState> {
  StoryCubit() : super(StoryState());

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

  List<ButtonObject> lstTopic = [
    ButtonObject(title: "Cổ tích", icon: AppImages.imgCoTich),
    ButtonObject(title: "Đạo đức", icon: AppImages.imgDaoDuc),
    ButtonObject(title: "Ngụ ngôn", icon: AppImages.imgNguNgon),
    ButtonObject(title: "Truyền thuyết", icon: AppImages.imgTruyenThuyet),
    ButtonObject(title: "Truyện cười", icon: AppImages.imgTruyenCuoi),
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
}
