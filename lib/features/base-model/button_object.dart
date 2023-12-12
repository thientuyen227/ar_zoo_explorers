class ButtonObject {
  String? id;
  final String title;
  String icon;
  bool isLoved;

  ButtonObject(
      {required this.title, required this.icon, this.isLoved = false, id});
}
