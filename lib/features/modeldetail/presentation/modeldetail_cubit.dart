import 'package:ar_zoo_explorers/features/modeldetail/model/image_argb.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

import '../../../base/base_cubit.dart';

@injectable
class ModelDetailCubit extends BaseCubit<ModelDetailState> {
  ModelDetailCubit() : super(ModelDetailState());

  String imagePath =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/user_images%2Fphoto-1-15951447028491980490713.jpeg?alt=media&token=501bd427-ec2f-4ae9-b4c6-a9bb30cd6a9a";
  String animalTitle = "default";

  double WIDTH = 0;
  double HEIGHT = 0;
  Color backgroundColor = Colors.white;
  ARGBImage listBlenderColor = ARGBImage();

  Future<img.Image> getImageFromNetwork(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      List<int> bytes = response.bodyBytes;
      return img.decodeImage(Uint8List.fromList(bytes))!;
    } else {
      throw Exception('Failed to load image from network');
    }
  }

  Future<img.Image> getImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List();
    return img.decodeImage(Uint8List.fromList(bytes))!;
  }

  Future<Color> getBlendedColorFromImage(String imagePath) async {
    img.Image image = img.Image.empty();
    try {
      image = await getImageFromNetwork(imagePath);
    } catch (e) {
      image = await getImageFromAssets(imagePath);
    }

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
