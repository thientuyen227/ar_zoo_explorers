import 'dart:convert';

import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class VocabularyEntity {
  final String id;
  final Map<String, String> words;
  final String thumbnail;
  final String? phoneticTranscription;
  final Map<String, String> audios;
  final Map<String, String> meaning;
  final Map<String, String> example;
  final String? status;

  VocabularyEntity(
      {required this.id,
      required this.words,
      required this.thumbnail,
      required this.phoneticTranscription,
      required this.audios,
      required this.meaning,
      required this.example,
      required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'words': words,
      'thumbnail': thumbnail,
      'phoneticTranscription': phoneticTranscription,
      'audios': audios,
      'meaning': meaning,
      'example': example,
      'status': status,
    };
  }

  factory VocabularyEntity.fromMap(Map<String, dynamic> map) {
    return VocabularyEntity(
      id: map['id'] as String,
      words: Map<String, String>.from((map['words'] ?? "")),
      thumbnail: map['thumbnail'] as String,
      phoneticTranscription: map['phoneticTranscription'] != null
          ? map['phoneticTranscription'] as String
          : null,
      audios: Map<String, String>.from((map['audios'] ?? "")),
      meaning: Map<String, String>.from((map['meaning'] ?? "")),
      example: Map<String, String>.from((map['example'] ?? "")),
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VocabularyEntity.fromJson(String source) =>
      VocabularyEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension VocabularyEntityExt on VocabularyEntity {
  String _getLocalizedValue(Map<String, String> data) {
    final languageCode = Get.locale?.languageCode;
    return data.containsKey(languageCode)
        ? data[languageCode]!
        : data.values.firstOrNull ?? "";
  }

  String get audiosLocalize => _getLocalizedValue(audios);
  String get wordLocalize => _getLocalizedValue(words);
  String get meaningLocalize => _getLocalizedValue(meaning);
  String get exampleLocalize => _getLocalizedValue(example);
}
