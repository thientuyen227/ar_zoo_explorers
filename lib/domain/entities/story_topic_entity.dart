class StoryTopicEntity {
  String id;
  String name;
  String title;
  String imageUrl;
  bool status;

  StoryTopicEntity(
      {required this.id,
      required this.name,
      required this.title,
      required this.imageUrl,
      required this.status});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'imageUrl': imageUrl,
      'status': status
    };
  }
}
