import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:injectable/injectable.dart';

import '../../../app/theme/icons.dart';
import '../../base-model/FormBuilderTextField_Model.dart';
import '../model/advertisement_object.dart';
import '../model/button_object.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());

  FormBuilderTextFieldModel searchBar = FormBuilderTextFieldModel(
      name: "search", hint_text: "search", icon_suffix: AppIcons.icSearch);

  List<ButtonObject> listButtonObject = [
    ButtonObject(title: "Mammals", icon: AppImages.imgMammals),
    ButtonObject(title: "Birds", icon: AppImages.imgBirds),
    ButtonObject(title: "Fishs", icon: AppImages.imgFishs),
    ButtonObject(title: "Amphibians", icon: AppImages.imgAmphibians),
    ButtonObject(title: "Reptiles", icon: AppImages.imgReptiles),
    ButtonObject(title: "Mollusks", icon: AppImages.imgMollusks),
    ButtonObject(title: "Arthropods", icon: AppImages.imgArthropods),
  ];

  AdvertisementObject listAdvertisement =
      AdvertisementObject([AppImages.imgAdvertisement, AppImages.imgAds1]);

  void isLoved(int index) {
    listButtonObject[index].isLoved = !listButtonObject[index].isLoved;
    print(listButtonObject[index].isLoved);
  }

  void onSearch(String? content) {
    print(content);
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
