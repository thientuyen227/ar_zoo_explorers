import 'dart:io';

import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class ARCubit extends BaseCubit<ARState> {
  ARCubit() : super(ARState());

  String? valueName;
  FirebaseStorage storage = FirebaseStorage.instance;

  HttpClient? httpClient;

  Future<Map<String, dynamic>> getFilePath(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename.glb');
    return {'dir': dir, 'file': file};
  }

  void downloadAndUnpack(String id, String url, String filename) async {
    Map<String, dynamic> filePathInfo = await getFilePath(filename);
    String dir = filePathInfo['dir'];
    File file = filePathInfo['file'];
    bool filePath = await checkFileExits(file.path);
    //get link download
    String modelUrl = await storage
        .ref()
        .child("animal_models/" '$filename' ".zip")
        .getDownloadURL();
    Fluttertoast.showToast(msg: modelUrl);
    if (!filePath) {
      var request = await httpClient!.getUrl(Uri.parse(modelUrl));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      await file.writeAsBytes(bytes);
    }
  }

  Future<bool> checkFileExits(String name) async {
    return File(name).exists();
  }

  Future<bool> downloadModel(String name) async {
    Map<String, dynamic> filePathInfo = await getFilePath(name);
    File file = filePathInfo['file'];
    bool fileExits = await checkFileExits(file.path);
    if (fileExits) {
      return true;
    }
    return false;
  }
}
