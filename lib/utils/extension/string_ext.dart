extension StringExt on String {
  String lastWords(int num) {
    final words = split(RegExp(r'\s+'));
    int from = words.length - num;
    if (from.isNegative) {
      return this;
    } else {
      return words.sublist(from).join(" ");
    }
  }

  String removeLastWord() {
    final words = split(RegExp(r' '));
    if (words.length <= 1) {
      return this;
    } else {
      return words.sublist(0, words.length - 1).join(" ");
    }
  }
}
