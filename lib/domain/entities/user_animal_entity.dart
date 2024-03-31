class UserAnimalEntity {
  String id;
  final String userId;
  final String modelId;
  final bool isLoved;

  UserAnimalEntity({
    required this.id,
    required this.userId,
    required this.modelId,
    required this.isLoved,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'modelId': modelId,
      'isLoved': isLoved,
    };
  }
}
