class UserStoryEntity {
  String id;
  String storyId;
  String userId;
  int pausedTime;
  bool isCompleted;
  bool isFavorited;
  bool status;

  UserStoryEntity({
    this.id = '',
    this.storyId = '',
    this.userId = '',
    this.pausedTime = 0,
    this.isCompleted = false,
    this.isFavorited = false,
    this.status = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storyId': storyId,
      'userId': userId,
      'pausedTime': pausedTime,
      'isCompleted': isCompleted,
      'isFavorited': isFavorited,
      'status': status,
    };
  }
}
