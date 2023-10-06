class Failure {
  final String? message;

  Failure({required this.message});
}

// General failures
class FirebaseAuthFailure extends Failure {
  final String code;
  FirebaseAuthFailure({super.message, required this.code});
}

class FirestoreFailure extends Failure {
  FirestoreFailure({super.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class CacheFailure extends Failure {
  CacheFailure({super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({super.message});
}
