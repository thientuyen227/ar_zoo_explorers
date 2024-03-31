import 'package:ar_zoo_explorers/features/searchmodel/presentation/searchmodel_state.dart';
import 'package:injectable/injectable.dart';

import '../../../app/theme/icons.dart';
import '../../../base/base_cubit.dart';
import '../../../domain/entities/animal_entity.dart';
import '../../base-model/button_object.dart';
import '../../base-model/form_builder_text_field_model.dart';

@injectable
class SearchModelCubit extends BaseCubit<SearchModelState> {
  SearchModelCubit() : super(SearchModelState());

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search", hint_text: "search", icon_suffix: AppIcons.icSearch);

  List<ButtonObject> listSearchAnimal = [];
  List<ButtonObject> listFullAnimal = [];

  void isLoved(int index) {
    listSearchAnimal[index].isLoved = !listSearchAnimal[index].isLoved;
    listFullAnimal[index].isLoved = !listFullAnimal[index].isLoved;
  }

  void setListAnimal(List<AnimalEntity> list, String searchValue) {
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        listFullAnimal.add(ButtonObject(
            title: list[i].title, icon: list[i].icon, id: list[i].id));
        if (list[i].title.toLowerCase().contains(searchValue.toLowerCase())) {
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
