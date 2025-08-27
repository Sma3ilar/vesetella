class DesignItemModel {
  final String id;
  final String title;
  final String color;
  final String number;
  final String fabric;
  final List<String> imagePaths; // A list for the 3 preview images

  DesignItemModel({
    required this.id,
    required this.title,
    required this.color,
    required this.number,
    required this.fabric,
    required this.imagePaths,
  });
}
