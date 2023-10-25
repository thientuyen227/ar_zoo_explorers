import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../core/success.dart';

class ResponseHandler {
  static Future<Either<Failure, Success<T>>> processResponse<T>(
      Future<Success<T>> Function() success) async {
    try {
      return Right(await success());
    }
    // Lỗi từ Firebase
    on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(message: e.message, code: e.code));
    }
    // Lỗi từ Firebase
    on FirebaseException catch (e) {
      return Left(FirestoreFailure(message: e.message));
    }
    // Lỗi không xác định
    on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
