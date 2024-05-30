import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_category_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_detail_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/animal_category_entity.dart';
import '../../base-model/button_object.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());

  final detailController = AnimalDetailController.findOrInitialize;
  final controller = AuthController.findOrInitialize;
  final cateController = AnimalCategoryController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  Future<void> init(BuildContext context) async {
    showLoading();

    await controller.getCurrentUser(context);
    await detailController.getAllAnimalDetails(context);
    await cateController.getAllAnimalCategories(context);

    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    await state.setAttributes(
      height: mediaSize.height,
      width: mediaSize.width,
      listAnimalCategory:
          await setAnimalCategories(cateController.listAnimalCategory.value),
    );
    print("Cubit.Init() : Get data");
    hideLoading();
  }

  Future<void> onChangeCurrentAdsPage(int newPage) async {
    await state.setAttributes(currentAdsPage: newPage);
  }

  Future<List<ButtonObject>> setAnimalCategories(
      List<AnimalCategoryEntity> list) async {
    List<ButtonObject> categories = [];
    if (list.isNotEmpty) {
      for (var category in list) {
        categories.add(ButtonObject(
            title: category.title, icon: category.imageUrl, id: category.id));
      }
    }
    return categories;
  }

  Future<void> setCurrentCategory(BuildContext context, int index) async {
    await cateController.updateCurrentAnimalCategory(
        context, state.listAnimalCategory[index].id!);
  }

  Future<void> getStoriesByReleaseDate(BuildContext context) async {
    await storyController.getStoriesByReleaseDate(context, true);
  }

  Future<void> getAllTopics(BuildContext context) async {
    await storyTopicController.getAllStoryTopics(context);
  }

  Future<void> isLoved(int index) async {
    state.listAnimalCategory[index].isLoved =
        !state.listAnimalCategory[index].isLoved;
    // print(listAnimalCategory[index].isLoved);
  }

  Future<void> onSearch(String? value) async {
    if (value != null) {
      value = value.trim();
    } else {
      value = "";
    }
    animalController.searchValue(value);
  }

  String nameCustom(String fullname, int index) {
    List<String> parts = fullname.split(" ");
    String ten = parts.last;
    if (ten.length > index) {
      ten = '${ten.substring(0, (index - 3))}...';
    }
    return ten;
  }
}
