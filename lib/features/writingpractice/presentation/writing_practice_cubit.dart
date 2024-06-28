import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/chars_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/writing_practice_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/writing_practice_user_entity.dart';
import 'package:ar_zoo_explorers/features/writingpractice/presentation/writing_practice_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class WritingPracticeCubit extends BaseCubit<WritingPracticeState> {
  WritingPracticeCubit() : super(WritingPracticeState());
  Future<void> init({String? type, required BuildContext context}) async {
    final languageCode = Get.locale?.languageCode;
    String vietnameseAlphabet = 'aăâbcdđeêghiklmnoôơpqrstuưvxy';
    String englishAlphabet = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20';
    List<String>? alphabetChars;
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    WritingPracticeController writingPracticeController =
        WritingPracticeController.findOrInitialize;
    CharsController charsController = CharsController.findOrInitialize;
    AuthController authController = AuthController.findOrInitialize;
    List<CharsEntity>? chasEntities =
        await charsController.getAllChars(context);
    if (type != 'number') {
      if (languageCode == 'en') {
        alphabetChars = englishAlphabet.split('');
      } else {
        alphabetChars = vietnameseAlphabet.split('');
      }
    } else {
      alphabetChars = numbers.split(' ');
    }
    List<CharsEntity> filteredEntities = [];
    for (var element in chasEntities!) {
      if (element.char != '' &&
              alphabetChars.contains(element.char.toLowerCase()) ||
          element.char == 'Empty') {
        WritingPracticeUserEntity? writingPracticeUserEntity =
            await writingPracticeController.getWritingPracticeByUser(
                context, authController.currentUser.value.id, element.id);
        if (writingPracticeUserEntity != null) {
          element.imagePaths = writingPracticeUserEntity.practicedImagePaths;
        }
        filteredEntities.add(element);
      }
    }

    filteredEntities.sort((a, b) {
      String aChar = a.char.toLowerCase();
      String bChar = b.char.toLowerCase();
      return alphabetChars!
          .indexOf(aChar)
          .compareTo(alphabetChars.indexOf(bChar));
    });
    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        charsEntities: filteredEntities));
  }
}
