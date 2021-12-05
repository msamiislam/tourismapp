class TripModel {
  final String id;
  final String title;
  final String coverImage;
  final int estimatedCost;

  TripModel({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.estimatedCost,
  });

  static TripModel fromJson(Map<String, dynamic> json) => TripModel(
    id: json["id"],
    title: json["title"],
    coverImage: json["coverImage"],
    estimatedCost: json["estimatedCost"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "coverImage": coverImage,
    "estimatedCost": estimatedCost,
  };
}
