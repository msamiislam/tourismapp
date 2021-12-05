class RestaurantModel {
  final String id;
  final String name;
  final List<String> images;
  final String city;
  final String location;
  final int rating;
  final int ratedPeople;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.images,
    required this.city,
    required this.location,
    required this.rating,
    required this.ratedPeople,
  });


  static fromJson(Map<String, dynamic> json) => RestaurantModel(
    id: json["id"],
    name: json["name"],
    images: List<String>.from(json["images"].map((x) => x)),
    city: json["city"],
    location: json["location"],
    rating: json["rating"],
    ratedPeople: json["ratedPeople"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "images": List<dynamic>.from(images.map((x) => x)),
    "city": city,
    "location": location,
    "rating": rating,
    "ratedPeople": ratedPeople,
  };
}
