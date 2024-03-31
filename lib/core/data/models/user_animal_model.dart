import 'package:ar_zoo_explorers/domain/entities/user_animal_entity.dart';

class UserAnimalModel extends UserAnimalEntity {
  UserAnimalModel(
      {required super.id,
      required super.userId,
      required super.modelId,
      required super.isLoved});

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'userId': userId, 'modelId': modelId, 'isLoved': isLoved};
  }

  factory UserAnimalModel.fromMap(Map<String, dynamic> map) {
    return UserAnimalModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      modelId: map['modelId'] ?? '',
      isLoved: map['isLoved'],
    );
  }
}
