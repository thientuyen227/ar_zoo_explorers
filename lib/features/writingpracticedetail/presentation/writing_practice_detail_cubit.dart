import 'dart:typed_data';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/chars_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/features/writingpracticedetail/presentation/writing_practice_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

@injectable
class WritingPracticeDetailCubit extends BaseCubit<WritingPracticeDetailState> {
  WritingPracticeDetailCubit() : super(WritingPracticeDetailState());
  List<CharsEntity>? listChars;

  Future<void> init(
    BuildContext context,
  ) async {
    CharsController charsController = CharsController.findOrInitialize;
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    listChars = await charsController.getAllChars(context);

    emit(state.copyWith(
        height: mediaSize.height,
        width: mediaSize.width,
        charsEntity: charsController.currentChars.value));
  }

  Uint8List resizeImage(Uint8List data, double width, double height) {
    img.Image image = img.decodeImage(data)!;
    img.Image resizedImage =
        img.copyResize(image, width: width.toInt(), height: height.toInt());
    return Uint8List.fromList(img.encodePng(resizedImage));
  }

  List<Color> generateBlackToWhiteColors() {
    List<Color> colors = [];
    colors.add(Colors.white);
    for (int i = 1; i < 20; i++) {
      double hue = (360 * i / 19) % 360;
      colors.add(HSVColor.fromAHSV(1, hue, 1, 1).toColor());
    }
    colors.add(Colors.black);
    return colors;
  }
}
