class TopicButtonObject {
  String id;
  String name;
  String title;
  String imageUrl;
  bool status;

  TopicButtonObject(
      {required this.id,
      required this.name,
      required this.title,
      required this.imageUrl,
      this.status = true});
}
