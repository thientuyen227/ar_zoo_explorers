import 'dart:typed_data';

import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';

class WritingPracticeState {
  final PageStatus pageStatus;
  double width;
  double height;
  Uint8List? backgroundImageBytes;
  List<CharsEntity> charsEntities;
  WritingPracticeState(
      {this.pageStatus = PageStatus.loading,
      this.height = 0,
      this.width = 0,
      this.backgroundImageBytes,
      this.charsEntities = const []});

  WritingPracticeState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    Uint8List? backgroundImageBytes,
    List<CharsEntity>? charsEntities,
  }) {
    return WritingPracticeState(
        pageStatus: pageStatus ?? this.pageStatus,
        height: height ?? this.height,
        width: width ?? this.width,
        backgroundImageBytes: backgroundImageBytes ?? this.backgroundImageBytes,
        charsEntities: charsEntities ?? this.charsEntities);
  }
}
