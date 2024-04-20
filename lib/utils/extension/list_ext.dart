extension ListExt<T> on List<T> {
  List<T> takeLast(int count) {
    final start = length - count;
    return getRange(start.isNegative ? 0 : start, length).toList();
  }

  List<T> clone() {
    return take(length).toList();
  }
}

extension StringExtensions on String {
  bool isValidUrl() {
    const pattern = r'^(https?:\/\/)?[\w\-]+(\.[\w\-]+)+[/#?]?.*$';
    final regex = RegExp(pattern, caseSensitive: false);
    return regex.hasMatch(this);
  }
}
