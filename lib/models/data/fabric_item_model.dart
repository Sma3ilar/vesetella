class FabricItemModel {
  final String id;
  final String title;
  final String color;
  final String number;
  final String type; // Renamed from fabric to be more specific
  final String imagePath; // A single image path

  FabricItemModel({
    required this.id,
    required this.title,
    required this.color,
    required this.number,
    required this.type,
    required this.imagePath,
  });
}
