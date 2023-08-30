import 'dart:convert';

import 'choice.dart';
import 'usage.dart';

class Completion {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;
  final Usage usage;
  Completion({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'object': object});
    result.addAll({'created': created});
    result.addAll({'model': model});
    result.addAll({'choices': choices.map((x) => x.toMap()).toList()});
    result.addAll({'usage': usage.toMap()});

    return result;
  }

  factory Completion.fromMap(Map<String, dynamic> map) {
    return Completion(
      id: map['id'] ?? '',
      object: map['object'] ?? '',
      created: map['created']?.toInt() ?? 0,
      model: map['model'] ?? '',
      choices: List<Choice>.from(map['choices']?.map((x) => Choice.fromMap(x))),
      usage: Usage.fromMap(map['usage']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Completion.fromJson(Map<String, dynamic> data) => Completion.fromMap(data);
}
