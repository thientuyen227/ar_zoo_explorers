class StoryButtonObject {
  String? id;
  String name;
  String avatar;
  String author;
  String reader;
  int listenCount;
  Duration duration;
  List<String> topic;
  Duration timestamp;
  bool isCompleted;

  StoryButtonObject(
      {this.id,
      this.name = "",
      required this.avatar,
      this.author = "Đang cập nhật",
      this.reader = "Đang cập nhật",
      this.duration = const Duration(seconds: 0, minutes: 0, hours: 0),
      this.timestamp = const Duration(seconds: 0, minutes: 0, hours: 0),
      required this.topic,
      this.listenCount = 0,
      this.isCompleted = false});
}
