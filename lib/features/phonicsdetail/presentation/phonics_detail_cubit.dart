import 'dart:async';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/chars_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/features/phonicsdetail/presentation/phonics_detail_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class PhonicsDetailCubit extends BaseCubit<PhonicsDetailState> {
  PhonicsDetailCubit() : super(PhonicsDetailState());
  CharsController charsController = CharsController.findOrInitialize;
  final languageCode = Get.locale?.languageCode;
  bool? isUpperCase;
  bool? isNumber;
  String vietnameseAlphabet = 'aăâbcdđeêghiklmnoôơpqrstuưvxy';
  String englishAlphabet = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20';
  List<String>? alphabetChars;
  Future<void> init({required BuildContext context, String? type}) async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    List<CharsEntity>? charsEntities =
        await charsController.getAllChars(context);
    if (type != 'number') {
      if (languageCode == 'en') {
        alphabetChars = englishAlphabet.split('');
      } else {
        alphabetChars = vietnameseAlphabet.split('');
      }
      if (type == 'upper') {
        isUpperCase = true;
      }
    } else {
      alphabetChars = numbers.split(' ');
      isNumber = true;
    }
    List<CharsEntity>? filteredEntities = charsEntities?.where((element) {
      return alphabetChars!.contains(element.char);
    }).toList();
    filteredEntities!.sort((a, b) {
      String aChar = a.char.toLowerCase();
      String bChar = b.char.toLowerCase();
      return alphabetChars!
          .indexOf(aChar)
          .compareTo(alphabetChars!.indexOf(bChar));
    });

    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        isNumber: isNumber,
        isUpperCase: isUpperCase,
        charsEntities: filteredEntities));
  }

  Map<String, String> audioUrlRead = {
    'en': "audio/vietnamesealphabet.mp3",
    'vi': "audio/vietnamesealphabet.mp3"
  };

  Map<String, String> audioUrlSing = {
    'en': "audio/abc_alphabat_song_en.mp3",
    'vi': "audio/alphabet.mp3"
  };
  Map<String, String> audioUrlReadNumbers = {
    'en': "audio/count_one_to_twenty_en.mp3",
    'vi': "audio/count_one_to_twenty_vi.mp3"
  };

  Map<String, String> audioUrlSingNumbers = {
    'en': "audio/count_one_to_twenty_en.mp3",
    'vi': "audio/count_one_to_twenty_vi.mp3"
  };

  Duration duration = const Duration(seconds: 1, minutes: 0);
  bool isPlaying = false;

  PlayerState audioState = PlayerState.stopped;
  bool isLoop = false;
}
