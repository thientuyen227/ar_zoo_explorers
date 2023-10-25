class Success<T> {
  final T data;
  final String? title;
  final String? message;

  Success({
    required this.data,
    this.title,
    this.message,
  });
}
