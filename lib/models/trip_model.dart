class TripModel {
  final String id;
  final String title;
  final String location;
  final String description;
  final String images;
  final int estimatedCost;
  final Map<String, String> itinerary;

  TripModel({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.images,
    required this.estimatedCost,
    required this.itinerary,
  });

  static TripModel fromJson(Map<String, dynamic> json) => TripModel(
      id: json["id"],
      title: json["title"],
      location: json["location"],
      description: json["description"],
      images: json["images"],
      estimatedCost: json["estimated_cost"],
      itinerary: json["itinerary"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "location": location,
        "description": description,
        "images": images,
        "estimated_cost": estimatedCost,
      };
}
