import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:injectable/injectable.dart';

import '../../../app/theme/icons.dart';
import '../../../domain/entities/animal_category_entity.dart';
import '../../base-model/button_object.dart';
import '../../base-model/form_builder_text_field_model.dart';
import '../model/advertisement_object.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());

  String urlAvatarUser = AppIcons.icDefaultUser;
  int adsCurrentPage = 0;

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search", hint_text: "search", icon_suffix: AppIcons.icSearch);

  List<ButtonObject> listAnimalCategory = [];

  AdvertisementObject listAdvertisement =
      AdvertisementObject([AppImages.imgAdvertisement, AppImages.imgAds1]);

  void setListAnimalCategory(List<AnimalCategoryEntity> list) {
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        listAnimalCategory.add(ButtonObject(
            title: list[i].title, icon: list[i].imageUrl, id: list[i].id));
      }
    }
  }

  void isLoved(int index) {
    listAnimalCategory[index].isLoved = !listAnimalCategory[index].isLoved;
    print(listAnimalCategory[index].isLoved);
  }

  String nameCustom(String fullname) {
    List<String> parts = fullname.split(" ");
    String ten = parts.last;
    if (ten.length > 8) {
      ten = '${ten.substring(0, 5)}...';
    }
    return ten;
  }
}
