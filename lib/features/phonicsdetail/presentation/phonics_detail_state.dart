import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';

class PhonicsDetailState {
  final PageStatus pageStatus;
  List<CharsEntity> charsEntities;
  double width;
  double height;
  bool isUpperCase;
  bool isNumber;
  PhonicsDetailState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
    this.isNumber = false,
    this.isUpperCase = false,
    this.charsEntities = const [],
  });

  PhonicsDetailState copyWith(
      {PageStatus? pageStatus,
      double? height,
      double? width,
      bool? isUpperCase,
      bool? isNumber,
      List<CharsEntity>? charsEntities}) {
    return PhonicsDetailState(
        pageStatus: pageStatus ?? this.pageStatus,
        height: height ?? this.height,
        width: width ?? this.width,
        isNumber: isNumber ?? this.isNumber,
        isUpperCase: isUpperCase ?? this.isUpperCase,
        charsEntities: charsEntities ?? this.charsEntities);
  }
}
