class AnimalDetailEntity {
  String id; // ID
  String modelId; // ID model của animal
  String description; // Mô tả
  String classification; // Phân loại sinh học
  String conservation; // Tình trạng bảo tồn
  String reproduction; // Sinh sản
  String culturalFigure; // Hình tượng trong văn hóa
  int views; // Lượt xem
  AnimalDetailEntity(
      {required this.id,
      required this.modelId,
      required this.description,
      required this.classification,
      required this.conservation,
      required this.reproduction,
      required this.culturalFigure,
      required this.views});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'modelId': modelId,
      'description': description,
      'classification': classification,
      'conservation': conservation,
      'reproduction': reproduction,
      'culturalFigure': culturalFigure,
      'views': views
    };
  }
}
