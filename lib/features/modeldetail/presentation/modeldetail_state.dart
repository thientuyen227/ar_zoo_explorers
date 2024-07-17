import 'package:ar_zoo_explorers/domain/entities/model_detail_entity.dart';
import 'package:ar_zoo_explorers/features/modeldetail/model/image_argb.dart';
import 'package:flutter/material.dart';

import '../../../app/app/app_state.dart';

class ModelDetailState {
  static const String defaultImgPath =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/user_images%2Fphoto-1-15951447028491980490713.jpeg?alt=media&token=501bd427-ec2f-4ae9-b4c6-a9bb30cd6a9a";

  final PageStatus pageStatus;
  bool isLoaded;
  bool isDownloading;

  double height;
  double width;
  int views;
  String imagePath;
  String animalTitle;
  Color backgroundColor;
  ARGBImage listBlenderColor;

  ModelDetailEntity detail;

  ModelDetailState({
    this.pageStatus = PageStatus.loading,
    this.isLoaded = false,
    this.isDownloading = false,
    this.height = 0,
    this.width = 0,
    this.views = 0,
    this.imagePath = defaultImgPath,
    this.animalTitle = "",
    this.backgroundColor = Colors.white,
    //INFORMATION OF MODEL
    ModelDetailEntity? detail,
    //INFORMATION OF ANIMAL MODEL
    ARGBImage? listBlenderColor,
  })  : listBlenderColor = ARGBImage(),
        detail = ModelDetailEntity(
            id: '',
            modelId: '',
            description: {
              'vi': '',
              'en': '',
            },
            classification: {
              'vi': '',
              'en': '',
            },
            conservation: {
              'vi': '',
              'en': '',
            },
            reproduction: {
              'vi': '',
              'en': '',
            },
            culturalFigure: {
              'vi': '',
              'en': '',
            },
            preservation: {
              'vi': '',
              'en': '',
            },
            culturalSignificance: {
              'vi': '',
              'en': '',
            },
            maintenance: {
              'vi': '',
              'en': '',
            },
            manufacturing: {
              'vi': '',
              'en': '',
            },
            educationalValue: {
              'vi': '',
              'en': '',
            },
            views: 0);

  ModelDetailState copyWith({
    PageStatus? pageStatus,
    bool? isLoaded,
    bool? isDownloading,
    double? height,
    double? width,
    int? views,
    String? imagePath,
    String? animalTitle,
    Color? backgroundColor,
    //INFORMATION OF ANIMAL MODEL
    ModelDetailEntity? detail,
    //INFORMATION OF ANIMAL MODEL
    ARGBImage? listBlenderColor,
  }) {
    return ModelDetailState(
      pageStatus: pageStatus ?? this.pageStatus,
      isLoaded: isLoaded ?? this.isLoaded,
      isDownloading: isDownloading ?? this.isDownloading,
      height: height ?? this.height,
      width: width ?? this.width,
      views: views ?? this.views,
      imagePath: imagePath ?? this.imagePath,
      animalTitle: animalTitle ?? this.animalTitle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      //INFORMATION OF ANIMAL MODEL
      detail: detail ?? this.detail,
      //INFORMATION OF ANIMAL MODEL
      listBlenderColor: listBlenderColor ?? this.listBlenderColor,
    );
  }

  setAttributes({
    PageStatus? pageStatus,
    bool? isLoaded,
    bool? isDownloading,
    double? height,
    double? width,
    int? views,
    String? imagePath,
    String? animalTitle,
    Color? backgroundColor,
    //INFORMATION OF ANIMAL MODEL
    ModelDetailEntity? detail,
    //INFORMATION OF ANIMAL MODEL
    ARGBImage? listBlenderColor,
  }) async {
    this.pageStatus ?? this.pageStatus;
    this.isLoaded = isLoaded ?? this.isLoaded;
    this.isDownloading = isDownloading ?? this.isDownloading;
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.views = views ?? this.views;
    this.imagePath = imagePath ?? this.imagePath;
    this.animalTitle = animalTitle ?? this.animalTitle;
    this.backgroundColor = backgroundColor ?? this.backgroundColor;
    //INFORMATION OF MODEL
    this.detail = detail ?? this.detail;
    //INFORMATION OF MODEL
    this.listBlenderColor = listBlenderColor ?? this.listBlenderColor;
  }
}
