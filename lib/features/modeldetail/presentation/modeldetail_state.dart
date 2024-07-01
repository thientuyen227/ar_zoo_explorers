import 'package:ar_zoo_explorers/features/modeldetail/model/image_argb.dart';
import 'package:flutter/material.dart';

import '../../../app/app/app_state.dart';

class ModelDetailState {
  static const String defaultImgPath =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/user_images%2Fphoto-1-15951447028491980490713.jpeg?alt=media&token=501bd427-ec2f-4ae9-b4c6-a9bb30cd6a9a";

  final PageStatus pageStatus;
  bool isLoaded;

  double height;
  double width;
  int views;
  String imagePath;
  String animalTitle;
  Color backgroundColor;
  ARGBImage listBlenderColor;

  //INFORMATIONs OF MODEL
  String description = ""; // Mô tả
  String classification = ""; // Phân loại sinh học
  String conservation = ""; // Tình trạng bảo tồn
  String reproduction = ""; // Sinh sản
  String culturalFigure = ""; // Hình tượng trong văn hóa

  ModelDetailState({
    this.pageStatus = PageStatus.loading,
    this.isLoaded = false,
    this.height = 0,
    this.width = 0,
    this.views = 0,
    this.imagePath = defaultImgPath,
    this.animalTitle = "",
    this.backgroundColor = Colors.white,
    //INFORMATION OF ANIMAL MODEL
    this.description = "",
    this.classification = "",
    this.conservation = "",
    this.reproduction = "",
    this.culturalFigure = "",
    //INFORMATION OF ANIMAL MODEL
    ARGBImage? listBlenderColor,
  }) : listBlenderColor = ARGBImage();

  ModelDetailState copyWith({
    PageStatus? pageStatus,
    bool? isLoaded,
    double? height,
    double? width,
    int? views,
    String? imagePath,
    String? animalTitle,
    Color? backgroundColor,
    //INFORMATION OF ANIMAL MODEL
    String? description,
    String? classification,
    String? conservation,
    String? reproduction,
    String? culturalFigure,
    //INFORMATION OF ANIMAL MODEL
    ARGBImage? listBlenderColor,
  }) {
    return ModelDetailState(
      pageStatus: pageStatus ?? this.pageStatus,
      isLoaded: isLoaded ?? this.isLoaded,
      height: height ?? this.height,
      width: width ?? this.width,
      views: views ?? this.views,
      imagePath: imagePath ?? this.imagePath,
      animalTitle: animalTitle ?? this.animalTitle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      //INFORMATION OF ANIMAL MODEL
      description: description ?? this.description,
      classification: classification ?? this.classification,
      conservation: conservation ?? this.conservation,
      reproduction: reproduction ?? this.reproduction,
      culturalFigure: culturalFigure ?? this.culturalFigure,
      //INFORMATION OF ANIMAL MODEL
      listBlenderColor: listBlenderColor ?? this.listBlenderColor,
    );
  }

  setAttributes({
    PageStatus? pageStatus,
    bool? isLoaded,
    double? height,
    double? width,
    int? views,
    String? imagePath,
    String? animalTitle,
    Color? backgroundColor,
    //INFORMATION OF ANIMAL MODEL
    String? description,
    String? classification,
    String? conservation,
    String? reproduction,
    String? culturalFigure,
    //INFORMATION OF ANIMAL MODEL
    ARGBImage? listBlenderColor,
  }) async {
    this.pageStatus ?? this.pageStatus;
    this.isLoaded ?? this.isLoaded;
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.views = views ?? this.views;
    this.imagePath = imagePath ?? this.imagePath;
    this.animalTitle = animalTitle ?? this.animalTitle;
    this.backgroundColor = backgroundColor ?? this.backgroundColor;
    //INFORMATION OF ANIMAL MODEL
    this.description = description ?? this.description;
    this.classification = classification ?? this.classification;
    this.conservation = conservation ?? this.conservation;
    this.reproduction = reproduction ?? this.reproduction;
    this.culturalFigure = culturalFigure ?? this.culturalFigure;
    //INFORMATION OF ANIMAL MODEL
    this.listBlenderColor = listBlenderColor ?? this.listBlenderColor;
  }
}
