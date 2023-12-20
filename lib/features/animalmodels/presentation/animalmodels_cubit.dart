import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_state.dart';
import 'package:injectable/injectable.dart';

import '../../../app/theme/icons.dart';
import '../../../base/base_cubit.dart';
import '../../../domain/entities/animal_entity.dart';
import '../../base-model/button_object.dart';
import '../../base-model/form_builder_text_field_model.dart';
import '../../home/model/advertisement_object.dart';

@injectable
class AnimalModelsCubit extends BaseCubit<AnimalModelsState> {
  AnimalModelsCubit() : super(AnimalModelsState());

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search", hint_text: "search", icon_suffix: AppIcons.icSearch);

  List<ButtonObject> listSearchAnimal = [];

  List<ButtonObject> listFullAnimal = [];

  double WIDTH = 0;
  double HEIGHT = 0;

  AdvertisementObject listAdvertisement =
      AdvertisementObject([AppImages.imgAdvertisement, AppImages.imgAds1]);

  void isLoved(int index) {
    listSearchAnimal[index].isLoved = !listSearchAnimal[index].isLoved;
    print(listSearchAnimal[index].isLoved);
  }

  String nameCustom(String fullname) {
    List<String> parts = fullname.split(" ");
    String ten = parts.last;
    if (ten.length > 8) {
      ten = '${ten.substring(0, 5)}...';
    }
    return ten;
  }

  void setListAnimal(List<AnimalEntity> list, String cateId) {
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].categoryId == cateId) {
          listFullAnimal.add(ButtonObject(
              title: list[i].title, icon: list[i].icon, id: list[i].id));
          listSearchAnimal.add(ButtonObject(
              title: list[i].title, icon: list[i].icon, id: list[i].id));
        }
      }
    }
  }

  void onSearch(String searchValue) {
    listSearchAnimal = [];
    for (int i = 0; i < listFullAnimal.length; i++) {
      if (listFullAnimal[i]
          .title
          .toLowerCase()
          .contains(searchValue.trim().toLowerCase())) {
        listSearchAnimal.add(ButtonObject(
            title: listFullAnimal[i].title,
            icon: listFullAnimal[i].icon,
            id: listFullAnimal[i].id,
            isLoved: listFullAnimal[i].isLoved,
            views: listFullAnimal[i].views));
      }
    }
  }
}
