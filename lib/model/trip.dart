class TripModel {
  final String uid;
  final String title;
  final String coverImage;
  final int estimatedCost;

  TripModel({
    required this.uid,
    required this.title,
    required this.coverImage,
    required this.estimatedCost,
  });

  static TripModel fromJson(Map<String, dynamic> json) => TripModel(
    uid: json["uid"],
    title: json["title"],
    coverImage: json["coverImage"],
    estimatedCost: json["estimatedCost"],
  );

  Map<String, dynamic> toJson(TripModel tripModel) => {
    "uid": tripModel.uid,
    "title": tripModel.title,
    "coverImage": tripModel.coverImage,
    "estimatedCost": tripModel.estimatedCost,
  };
}
