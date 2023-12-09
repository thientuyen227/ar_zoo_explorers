import 'package:ar_zoo_explorers/features/modleldetail/model/image_argb.dart';
import 'package:ar_zoo_explorers/features/modleldetail/presentation/modeldetail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

import '../../../base/base_cubit.dart';

@injectable
class ModelDetailCubit extends BaseCubit<ModelDetailState> {
  ModelDetailCubit() : super(ModelDetailState());
  double WIDTH = 0;
  double HEIGHT = 0;
  Color backgroundColor = Colors.white;
  ARGBImage listBlenderColor = ARGBImage();

  Future<img.Image> getImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List();
    return img.decodeImage(Uint8List.fromList(bytes))!;
  }

  Future<Color> getBlendedColorFromImage(String imagePath) async {
    img.Image image = await getImageFromAssets(imagePath);

    getColorPoint(image);

    int blendedR = listBlenderColor.blendedRed();
    int blendedG = listBlenderColor.blendedGreen();
    int blendedB = listBlenderColor.blendedBlue();
    int blendedA = listBlenderColor.weightSum().round();

    return Color.fromARGB(blendedA, blendedR, blendedG, blendedB);
  }

  void getColorPoint(img.Image image) {
    int dWidth = (image.width / 5).round();
    int dHeight = (image.height / 5).round();
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        listBlenderColor.add(image.getPixel(dWidth * i, dHeight * j));
      }
    }
  }
}
