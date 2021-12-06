class HotelModel {
  HotelModel({
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

  static HotelModel fromJson(Map<String, dynamic> json) {
    return HotelModel(
    id: json["id"],
    name: json["name"],
    images: List<String>.from(json["images"].map((x) => x)),
    city: json["city"],
    location: json["location"],
  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "images": List<dynamic>.from(images.map((x) => x)),
    "city": city,
    "location": location,
  };
}
