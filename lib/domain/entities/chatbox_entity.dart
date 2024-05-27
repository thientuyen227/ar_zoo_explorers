class ChatBoxEntity {
  String prediction;
  List<GeneratedFile>? generatedFiles;
  String sourceId;
  String sourceType;
  String status;
  String statusDescription;
  String prompt;

  ChatBoxEntity({
    required this.prediction,
    this.generatedFiles,
    required this.sourceId,
    required this.sourceType,
    required this.status,
    required this.statusDescription,
    required this.prompt,
  });

  factory ChatBoxEntity.fromJson(Map<String, dynamic> json) {
    List<dynamic> generatedFilesJson = json['generated_files'] ?? [];
    List<GeneratedFile> generatedFilesList = generatedFilesJson
        .map((fileJson) => GeneratedFile.fromJson(fileJson))
        .toList();

    return ChatBoxEntity(
      prediction: json['prediction'] ?? '',
      generatedFiles: generatedFilesList,
      sourceId: json['source_id'] ?? '',
      sourceType: json['source_type'] ?? '',
      status: json['status'] ?? '',
      statusDescription: json['status_description'] ?? '',
      prompt: json['prompt'] ?? '',
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
