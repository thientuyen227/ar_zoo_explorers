import 'dart:convert';

import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharsEntity {
  final String id;
  final String char;
  final Map<String?, String?> audios;
  Map<String?, String?> imagePaths;

  CharsEntity(
      {required this.id,
      required this.char,
      required this.audios,
      required this.imagePaths});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'char': char,
      'audios': audios,
      'imagePaths': imagePaths,
    };
  }

  factory CharsEntity.fromMap(Map<String, dynamic> map) {
    return CharsEntity(
      id: map['id'] ?? '',
      char: map['char'] ?? '',
      imagePaths: map['imagePaths'] != null
          ? Map<String?, String?>.from(map['imagePaths'] as Map)
          : <String?, String?>{},
      audios: map['audios'] != null
          ? Map<String?, String?>.from(map['audios'] as Map)
          : <String?, String?>{},
    );
  }

  String toJson() => json.encode(toMap());

  factory CharsEntity.fromJson(String source) =>
      CharsEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension CharsEntityExt on CharsEntity {
  String get audiosLocalize {
    final languageCode = Get.locale?.languageCode;
    if (audios.containsKey(languageCode)) {
      return audios[languageCode]!;
    }
    return audios.values.firstOrNull ?? "";
  }

  String get imagePathsLocalize {
    final languageCode = Get.locale?.languageCode;
    if (imagePaths.containsKey(languageCode)) {
      return imagePaths[languageCode]!;
    }
    return imagePaths.values.firstOrNull ?? "";
  }

  // CharacterimagePaths get characterimagePaths {
  //   return CharacterimagePaths.values.firstWhere((element) => element.name == imagePaths);
  // }
}
