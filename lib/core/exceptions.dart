class FirebaseFirestoreException {
  final String message;

  FirebaseFirestoreException({
    required this.message,
  });
}

class UnknownException implements Exception {
  final dynamic e;

  UnknownException(this.e);
}
