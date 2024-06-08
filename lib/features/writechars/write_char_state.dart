import 'dart:typed_data';

import 'package:ar_zoo_explorers/app/app/app_state.dart';

class WriteCharsState {
  final PageStatus pageStatus;
  double width;
  double height;
  Uint8List? backgroundImageBytes;
  WriteCharsState(
      {this.pageStatus = PageStatus.loading,
      this.height = 0,
      this.width = 0,
      this.backgroundImageBytes});

  WriteCharsState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    Uint8List? backgroundImageBytes,
  }) {
    return WriteCharsState(
        pageStatus: pageStatus ?? this.pageStatus,
        height: height ?? this.height,
        width: width ?? this.width,
        backgroundImageBytes:
            backgroundImageBytes ?? this.backgroundImageBytes);
  }
}
