import 'dart:convert';

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'prompt_tokens': promptTokens});
    result.addAll({'completion_tokens': completionTokens});
    result.addAll({'total_tokens': totalTokens});

    return result;
  }

  factory Usage.fromMap(Map<String, dynamic> map) {
    return Usage(
      promptTokens: map['prompt_tokens']?.toInt() ?? 0,
      completionTokens: map['completion_tokens']?.toInt() ?? 0,
      totalTokens: map['total_tokens']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usage.fromJson(String source) => Usage.fromMap(json.decode(source));
}
