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

  factory MallModel.fromJson(Map<String, dynamic> json) => MallModel(
    id: json["id"],
    name: json["name"],
    images: List<String>.from(json["images"].map((x) => x)),
    city: json["city"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "images": List<dynamic>.from(images.map((x) => x)),
    "city": city,
    "location": location,
  };
}
