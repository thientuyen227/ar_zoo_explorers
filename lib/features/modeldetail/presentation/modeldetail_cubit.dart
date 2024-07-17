import 'dart:io';

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/model_detail_controller.dart';
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_state.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../../base/base_cubit.dart';

@injectable
class ModelDetailCubit extends BaseCubit<ModelDetailState> {
  ModelDetailCubit() : super(ModelDetailState());

  final animalController = AnimalController.findOrInitialize;
  final detailController = ModelDetailController.findOrInitialize;

  final ValueNotifier<bool> isClosedLoading = ValueNotifier<bool>(false);

  FirebaseStorage storage = FirebaseStorage.instance;

  HttpClient? httpClient;

  final languageCode = Get.locale?.languageCode;

  Future<void> init(BuildContext context) async {
    showLoading();
    await Future.delayed(const Duration(milliseconds: 1350));
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    await detailController.getModelDetailByModelId(context,
        modelId: animalController.currentAnimal.value.id);
    await detailController.updateViewsModelModel(context,
        id: detailController.currentModelDetail.value.id,
        views: (detailController.currentModelDetail.value.views + 1));
    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
      animalTitle: animalController.currentAnimal.value.titles[languageCode],
      imagePath: animalController.currentAnimal.value.icon,
      views: detailController.currentModelDetail.value.views,
    ));
    await _setBackgroundColor();

    emit(state.copyWith(
      detail: await detailController.getDetail(),
      isDownloading: false,
      isLoaded: true,
    ));

    print("Cubit.Init() : Get data");

    isClosedLoading.value = !isClosedLoading.value;
    hideLoading();
  }

  Future<void> onChangeBackgroundColor(Color newColor) async {
    emit(state.copyWith(backgroundColor: newColor));
  }

  Future<void> onChangeDownloadStatus(bool status) async {
    emit(state.copyWith(isDownloading: status));
  }

  Future<void> _setBackgroundColor() async {
    Color newColor = await getBlendedColorFromImage(state.imagePath);
    await onChangeBackgroundColor(newColor);
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
    try {
      await onChangeDownloadStatus(true);
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
      await onChangeDownloadStatus(false);
      print("TTTT model: ${file.path}");
      Fluttertoast.showToast(
          msg: "${(LanguageKeys.msg_download_model_success.tr)}!");
    } catch (e, stackTrace) {
      print('[Download model Failed: $e]');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
      Fluttertoast.showToast(
          msg: "${(LanguageKeys.msg_download_model_failed.tr)}!");
      await Future.delayed(const Duration(milliseconds: 2000));
      await onChangeDownloadStatus(false);
    }
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
