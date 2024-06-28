// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';

class WritingPracticeDetailState {
  final PageStatus pageStatus;
  final double width;
  final double height;
  final Uint8List? backgroundImageBytes;
  final CharsEntity? charsEntity;
  WritingPracticeDetailState({
    this.pageStatus = PageStatus.loading,
    this.width = 0,
    this.height = 0,
    this.backgroundImageBytes,
    this.charsEntity,
  });

  WritingPracticeDetailState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    Uint8List? backgroundImageBytes,
    CharsEntity? charsEntity,
  }) {
    return WritingPracticeDetailState(
        pageStatus: pageStatus ?? this.pageStatus,
        height: height ?? this.height,
        width: width ?? this.width,
        backgroundImageBytes: backgroundImageBytes ?? this.backgroundImageBytes,
        charsEntity: charsEntity ?? this.charsEntity);
  }
}
