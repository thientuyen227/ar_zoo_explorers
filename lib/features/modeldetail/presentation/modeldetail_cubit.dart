import 'dart:io';

import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_detail_controller.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../../base/base_cubit.dart';

@injectable
class ModelDetailCubit extends BaseCubit<ModelDetailState> {
  ModelDetailCubit() : super(ModelDetailState());

  final animalController = AnimalController.findOrInitialize;
  final detailController = AnimalDetailController.findOrInitialize;

  final ValueNotifier<bool> isClosedLoading = ValueNotifier<bool>(true);

  FirebaseStorage storage = FirebaseStorage.instance;

  HttpClient? httpClient;

  Future<void> init(BuildContext context) async {
    showLoading();
    await Future.delayed(const Duration(milliseconds: 1350));
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    await detailController.getAnimalCategoryModelByModelId(context,
        modelId: animalController.currentAnimal.value.id);
    await detailController.updateViewsAnimalModel(context,
        id: detailController.currentAnimalDetail.value.id,
        views: (detailController.currentAnimalDetail.value.views + 1));
    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
      animalTitle: animalController.currentAnimal.value.title,
      imagePath: animalController.currentAnimal.value.icon,
      views: detailController.currentAnimalDetail.value.views,
    ));
    await _setBackgroundColor();

    emit(state.copyWith(
      //INFORMATION OF ANIMAL MODEL
      description: detailController.currentAnimalDetail.value.description,
      classification: detailController.currentAnimalDetail.value.classification,
      conservation: detailController.currentAnimalDetail.value.conservation,
      reproduction: detailController.currentAnimalDetail.value.reproduction,
      culturalFigure: detailController.currentAnimalDetail.value.culturalFigure,
      //INFORMATION OF ANIMAL MODEL
      isLoaded: true,
    ));

    print("Cubit.Init() : Get data");

    isClosedLoading.value = !isClosedLoading.value;
    hideLoading();
  }

  Future<void> _setBackgroundColor() async {
    Color newColor = await getBlendedColorFromImage(state.imagePath);
    state.backgroundColor = newColor;
  }

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

    int blendedR = state.listBlenderColor.blendedRed();
    int blendedG = state.listBlenderColor.blendedGreen();
    int blendedB = state.listBlenderColor.blendedBlue();
    int blendedA = state.listBlenderColor.weightSum().round();

    return Color.fromARGB(blendedA, blendedR, blendedG, blendedB);
  }

  void getColorPoint(img.Image image) {
    int dWidth = (image.width / 5).round();
    int dHeight = (image.height / 5).round();
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        state.listBlenderColor.add(image.getPixel(dWidth * i, dHeight * j));
      }
    }
  }

  // DOWNLOAD MODEL
  Future<Map<String, dynamic>> getFilePath(String filename, String type) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename.$type');
    return {'dir': dir, 'file': file};
  }

  Future<bool> checkFileExits(String name) async {
    return File(name).exists();
  }

  Future<void> downloadAndUnpack(String filename, String type) async {
    Map<String, dynamic> filePathInfo = await getFilePath(filename, type);
    File file = filePathInfo['file'];
    bool filePath = await checkFileExits(file.path);
    //get link download
    String modelUrl = await storage
        .ref()
        .child("animal_models/" '$filename.$type')
        .getDownloadURL();
    //Fluttertoast.showToast(msg: modelUrl);
    httpClient = HttpClient();

    if (!filePath) {
      var request = await httpClient!.getUrl(Uri.parse(modelUrl));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      await file.writeAsBytes(bytes);
    }
    print("TTTT model: ${file.path}");
    Fluttertoast.showToast(msg: "Download thành công!");
  }

  Future<bool> downloadModel(String name, String type) async {
    Map<String, dynamic> filePathInfo = await getFilePath(name, type);
    File file = filePathInfo['file'];
    bool fileExits = await checkFileExits(file.path);
    if (fileExits) {
      return true;
    }
    return false;
  }
}
