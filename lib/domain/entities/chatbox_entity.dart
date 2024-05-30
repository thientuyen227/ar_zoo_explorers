// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatBoxEntity {
  String prediction;
  List<GeneratedFile>? generatedFiles;
  String sourceId;
  String? sourceType;
  String? status;
  String? statusDescription;
  String? prompt;

  ChatBoxEntity({
    required this.prediction,
    this.generatedFiles,
    required this.sourceId,
    this.sourceType,
    this.status,
    this.statusDescription,
    this.prompt,
  });

  factory ChatBoxEntity.fromJson(Map<String, dynamic> json) {
    List<GeneratedFile>? generatedFilesList;
    try {
      List<dynamic> generatedFilesJson = json['generated_files'] ?? [];
      generatedFilesList = generatedFilesJson
          .map((fileJson) => GeneratedFile.fromJson(fileJson))
          .toList();
    } catch (e) {
      print("TTTTTT $e");
    }

    return ChatBoxEntity(
      prediction: json['prediction'] ?? '',
      generatedFiles: generatedFilesList ?? [],
      sourceId: json['source_id'] ?? '',
      sourceType: json['source_type'] ?? '',
      status: json['status'] ?? '',
      statusDescription: json['status_description'] ?? '',
      prompt: json['prompt'] ?? '',
    );
  }

  ChatBoxEntity copyWith({
    String? prediction,
    List<GeneratedFile>? generatedFiles,
    String? sourceId,
    String? sourceType,
    String? status,
    String? statusDescription,
    String? prompt,
  }) {
    return ChatBoxEntity(
      prediction: prediction ?? this.prediction,
      generatedFiles: generatedFiles ?? this.generatedFiles,
      sourceId: sourceId ?? this.sourceId,
      sourceType: sourceType ?? this.sourceType,
      status: status ?? this.status,
      statusDescription: statusDescription ?? this.statusDescription,
      prompt: prompt ?? this.prompt,
    );
  }
}

class GeneratedFile {
  String fileUrl;
  String fileType;

  GeneratedFile({
    required this.fileUrl,
    required this.fileType,
  });

  factory GeneratedFile.fromJson(Map<String, dynamic> json) {
    return GeneratedFile(
      fileUrl: json['file_url'] ?? '',
      fileType: json['file_type'] ?? '',
    );
  }
}
