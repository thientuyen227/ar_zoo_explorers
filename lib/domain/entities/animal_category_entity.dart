class AnimalCategoryEntity {
  final String id;
  final String name;
  final String title;
  final String imageUrl;
  final bool status;

  AnimalCategoryEntity(
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
