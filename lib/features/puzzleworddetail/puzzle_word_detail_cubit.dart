import 'dart:math';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/puzzleworddetail/puzzle_word_detail_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PuzzleWordDetailCubit extends BaseCubit<PuzzleWordDetailState> {
  PuzzleWordDetailCubit() : super(PuzzleWordDetailState());
  List<String> generateKeywords(String answer, int totalKeywords) {
    List<String> keywords = answer.split('');

    List<String> alphabetChars = 'abcdefghijklmnopqrstuvwxyz'.split('');

    int missingKeywordsCount = totalKeywords - keywords.length;
    if (missingKeywordsCount > 0) {
      Random random = Random();
      for (int i = 0; i < missingKeywordsCount; i++) {
        int randomIndex = random.nextInt(alphabetChars.length);
        keywords.add(alphabetChars[randomIndex]);
      }
    }
    keywords.shuffle();

    return keywords;
  }
}
