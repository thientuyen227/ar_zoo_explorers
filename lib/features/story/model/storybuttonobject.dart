class StoryButtonObject {
  String? id;
  String name;
  String avatar;
  String author;
  String reader;
  int listenCount;
  Duration duration;
  String topic;
  Duration timestamp;

  StoryButtonObject(
      {this.id,
      required this.name,
      required this.avatar,
      this.author = "Đang cập nhật",
      this.reader = "Đang cập nhật",
      this.duration = const Duration(seconds: 0, minutes: 0, hours: 0),
      this.timestamp = const Duration(seconds: 0, minutes: 0, hours: 0),
      required this.topic,
      this.listenCount = 0});
}
