abstract class AttractionModel {
  final String id;
  final String name;
  final String city;
  final String address;
  final String type;
  final List<String> images;

  AttractionModel({
    required this.id,
    required this.name,
    required this.city,
    required this.type,
    required this.images,
    required this.address,
  });
}

class AttractionType {
  static const String place = "Place";
  static const String mall = "Mall";
  static const String restaurant = "Restaurant";
  static const String hotel = "Hotel";
}
