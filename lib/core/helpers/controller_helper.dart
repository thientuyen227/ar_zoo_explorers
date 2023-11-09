import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../core/failures.dart';
import '../../core/success.dart';

class ControllerHelper extends GetxController {
  Future<T> processRequest<T>({
    required Future<Either<Failure, Success<T>>> Function() request,
    Function(Failure failure)? onFailure,
    Function(Success<T> success)? onSuccess,
  }) async {
    Future<Either<Failure, Success<T>>> requestFuture = request();
    Either<Failure, Success<T>> result = await requestFuture;

    return await result.fold(
      (failure) async {
        if (onFailure != null) onFailure(failure);
        return Future.error(failure.message ?? "");
      },
      (success) async {
        if (onSuccess != null) onSuccess(success);

        return success.data;
      },
    );
  }
}
