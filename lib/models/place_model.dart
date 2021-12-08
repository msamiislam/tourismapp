import 'package:tourismapp/models/attraction_model.dart';

class PlaceModel extends AttractionModel {
  PlaceModel({
    required String id,
    required String name,
    required String city,
    required String address,
    required List<String> images,
  }) : super(
          id: id,
          name: name,
          city: city,
          address: address,
          type: AttractionType.place,
          images: images,
        );

  static PlaceModel fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json["id"],
      name: json["name"],
      images: json["images"],
      city: json["city"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "images": images,
      "city": city,
      "address": address,
      "type": type,
    };
  }
}
