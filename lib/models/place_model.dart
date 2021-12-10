import 'package:tourismapp/models/attraction_model.dart';

class PlaceModel extends AttractionModel {
  PlaceModel({
    required String id,
    required String name,
    required String city,
    required String address,
    required String description,
    required double rating,
    required List<String> images,
  }) : super(
    id: id,
          name: name,
          city: city,
          address: address,
          description: description,
          rating: rating,
          type: AttractionType.place,
          images: images,
        );

  static PlaceModel fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json["id"],
      name: json["name"],
      images: (json["images"] as List).map((e) => e.toString()).toList(),
      city: json["city"],
      address: json["address"],
      description: json["description"],
      rating: json["rating"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "images": images,
      "city": city,
      "address": address,
      "description": description,
      "rating": rating,
      "type": type,
    };
  }
}
