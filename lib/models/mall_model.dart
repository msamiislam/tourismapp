class MallModel {
  MallModel({
    required this.id,
    required this.name,
    required this.images,
    required this.city,
    required this.location,
  });

  final String id;
  final String name;
  final List<String> images;
  final String city;
  final String location;

  static MallModel fromJson(Map<String, dynamic> json) {
    return MallModel(
      id: json["id"],
      name: json["name"],
      images: json["images"],
      city: json["city"],
      location: json["location"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "images": images,
      "city": city,
      "location": location,
    };
  }
}
