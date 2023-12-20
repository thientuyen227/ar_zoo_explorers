class ButtonObject {
  String? id;
  final String title;
  String icon;
  int? views;
  bool isLoved;

  ButtonObject(
      {required this.title,
      required this.icon,
      this.isLoved = false,
      this.id,
      this.views});
}
