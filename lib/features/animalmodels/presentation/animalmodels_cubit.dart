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

  // List<ButtonObject> mammals = [
  //   ButtonObject(title: 'Bat', icon: AppImages.imgBat),
  //   ButtonObject(title: 'Buffalo', icon: AppImages.imgBuffalo),
  //   ButtonObject(title: 'Cat', icon: AppImages.imgCat),
  //   ButtonObject(title: 'Cow', icon: AppImages.imgCow),
  //   ButtonObject(title: 'Deer', icon: AppImages.imgDeer),
  //   ButtonObject(title: 'Dog', icon: AppImages.imgDog),
  //   ButtonObject(title: 'Dolphin', icon: AppImages.imgDolphin),
  //   ButtonObject(title: 'Elephant', icon: AppImages.imgElephant),
  //   ButtonObject(title: 'Hippo', icon: AppImages.imgHippo),
  //   ButtonObject(title: 'Leopard', icon: AppImages.imgLeopard),
  //   ButtonObject(title: 'Lion', icon: AppImages.imgLion),
  //   ButtonObject(title: 'Monkey', icon: AppImages.imgMonkey),
  //   ButtonObject(title: 'Mouse', icon: AppImages.imgMouse),
  //   ButtonObject(title: 'Pig', icon: AppImages.imgPig),
  //   ButtonObject(title: 'Rabbit', icon: AppImages.imgRabbit),
  //   ButtonObject(title: 'Rhino', icon: AppImages.imgRhino),
  //   ButtonObject(title: 'Sheep', icon: AppImages.imgSheep),
  //   ButtonObject(title: 'Tiger', icon: AppImages.imgTiger),
  //   ButtonObject(title: 'Whales', icon: AppImages.imgWhale),
  //   ButtonObject(title: 'Wolf', icon: AppImages.imgWolf),
  // ];

  // List<ButtonObject> birds = [
  //   ButtonObject(title: 'Chicken', icon: AppImages.imgChicken),
  //   ButtonObject(title: 'Duck', icon: AppImages.imgDuck),
  //   ButtonObject(title: 'Eagle', icon: AppImages.imgEagle),
  // ];

  // List<ButtonObject> fishes = [
  //   ButtonObject(title: 'Angelfish', icon: AppImages.imgAngelfish),
  //   ButtonObject(title: 'Hammer Shark', icon: AppImages.imgHammerShark),
  //   ButtonObject(title: 'Shark', icon: AppImages.imgShark),
  // ];

  // List<ButtonObject> reptiles = [
  //   ButtonObject(title: 'Crocodile', icon: AppImages.imgCrocodile),
  //   ButtonObject(title: 'Snake', icon: AppImages.imgSnake),
  //   ButtonObject(title: 'Turtle', icon: AppImages.imgTurtle),
  // ];

  // List<ButtonObject> arthropods = [
  //   ButtonObject(title: 'Spider', icon: AppImages.imgSpider),
  // ];

  // List<ButtonObject> mollusks = [];
  // List<ButtonObject> amphibians = [];

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
            id: listFullAnimal[i].id));
      }
    }
  }
}
