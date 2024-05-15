import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharsEntity {
  final String id;
  final String char;
  final String type;
  final Map<String, String> audios;

  CharsEntity(
      {required this.id,
      required this.char,
      required this.type,
      required this.audios});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'char': char,
      'type': type,
      'audios': audios,
    };
  }

  factory CharsEntity.fromMap(Map<String, dynamic> map) {
    return CharsEntity(
      id: map['id'] ?? '',
      char: map['char'] ?? '',
      type: map['type'] ?? '',
      audios: Map<String, String>.from((map['audios'] ?? {})),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharsEntity.fromJson(String source) =>
      CharsEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharsEntity &&
        other.id == id &&
        other.char == char &&
        other.type == type &&
        mapEquals(other.audios, audios);
  }

  @override
  int get hashCode {
    return id.hashCode ^ char.hashCode ^ type.hashCode ^ audios.hashCode;
  }
}

extension CharsEntityExt on CharsEntity {
  String get audiosLocalize {
    final languageCode = Get.locale?.languageCode;
    if (audios.containsKey(languageCode)) {
      return audios[languageCode]!;
    }
    return audios.values.firstOrNull ?? "";
  }

  // CharacterType get characterType {
  //   return CharacterType.values.firstWhere((element) => element.name == type);
  // }
}
