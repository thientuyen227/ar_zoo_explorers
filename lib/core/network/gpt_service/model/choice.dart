import 'dart:convert';

enum FinishReason {
  length,
  stop,
  other;

  String toMap() {
    return name;
  }

  static FinishReason fromMap(dynamic value) {
    return FinishReason.values.firstWhere(
      (element) => element.name == value,
      orElse: () => FinishReason.other,
    );
  }
}

class Choice {
  final String text;
  final int index;
  final int? logprobs;
  final FinishReason finishReason;
  Choice({
    required this.text,
    required this.index,
    this.logprobs,
    required this.finishReason,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'index': index});
    if (logprobs != null) {
      result.addAll({'logprobs': logprobs});
    }
    result.addAll({'finish_reason': finishReason.toMap()});

    return result;
  }

  factory Choice.fromMap(Map<String, dynamic> map) {
    return Choice(
      text: map['text'] ?? '',
      index: map['index']?.toInt() ?? 0,
      logprobs: map['logprobs']?.toInt(),
      finishReason: FinishReason.fromMap(map['finish_reason']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Choice.fromJson(String source) => Choice.fromMap(json.decode(source));
}
