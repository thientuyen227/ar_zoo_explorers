import 'dart:convert';

import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class VocabularyEntity {
  late final String id;
  final Map<String, String> words;
  final String thumbnail;
  String categoryId;
  String? modelId;
  final String? phoneticTranscription;
  final Map<String, String> audios;
  final Map<String, String> meaning;
  final Map<String, String> example;
  final Map<String, String>? audioMeanings;
  final Map<String, String>? audioExamples;
  final String? status;

  VocabularyEntity(
      {required this.id,
      required this.words,
      required this.thumbnail,
      required this.categoryId,
      required this.modelId,
      required this.phoneticTranscription,
      required this.audios,
      required this.meaning,
      required this.example,
      required this.audioMeanings,
      required this.audioExamples,
      required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'words': words,
      'categoryId': categoryId,
      'modelId': modelId,
      'thumbnail': thumbnail,
      'phoneticTranscription': phoneticTranscription,
      'audios': audios,
      'meaning': meaning,
      'example': example,
      'audioMeanings': audioMeanings,
      'audioExamples': audioExamples,
      'status': status,
    };
  }

  factory VocabularyEntity.fromMap(Map<String, dynamic> map) {
    return VocabularyEntity(
      id: map['id'] as String,
      words: map['words'] is Map<String, dynamic>
          ? Map<String, String>.from(map['words'])
          : <String, String>{},
      categoryId: map['categoryId'] as String,
      modelId: map['modelId'] != null ? map['modelId'] as String : null,
      thumbnail: map['thumbnail'] as String,
      phoneticTranscription: map['phoneticTranscription'] != null
          ? map['phoneticTranscription'] as String
          : null,
      audios: map['audios'] is Map<String, dynamic>
          ? Map<String, String>.from(map['audios'])
          : <String, String>{},
      meaning: map['meaning'] is Map<String, dynamic>
          ? Map<String, String>.from(map['meaning'])
          : <String, String>{},
      example: map['example'] is Map<String, dynamic>
          ? Map<String, String>.from(map['example'])
          : <String, String>{},
      audioMeanings: map['audioMeanings'] is Map<String, dynamic>
          ? Map<String, String>.from(map['audioMeanings'])
          : null,
      audioExamples: map['audioExamples'] is Map<String, dynamic>
          ? Map<String, String>.from(map['audioExamples'])
          : null,
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
  String get audiosMeaningsLocalize => _getLocalizedValue(audioMeanings!);
  String get audiosExampleLocalize => _getLocalizedValue(audioExamples!);
}
