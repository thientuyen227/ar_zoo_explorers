import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/writechars/write_char_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class WriteCharsCubit extends BaseCubit<WriteCharsState> {
  WriteCharsCubit() : super(WriteCharsState());
  Future<void> init() async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
    ));
  }
}
