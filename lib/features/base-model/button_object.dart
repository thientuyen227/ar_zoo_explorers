class ButtonObject {
  String? id;
  Map<String, String> title;
  String icon;
  int? views;
  bool isLoved;
  String? cateId;

  ButtonObject(
      {required this.title,
      required this.icon,
      this.isLoved = false,
      this.id,
      this.views,
      this.cateId});
}
