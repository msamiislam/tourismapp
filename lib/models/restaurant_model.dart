import '../models/attraction_model.dart';

class RestaurantModel extends AttractionModel {
  final String phone;
  final String link;

  RestaurantModel({
    required String id,
    required String name,
    required String city,
    required String address,
    required List<String> images,
    required this.phone,
    required this.link,
  }) : super(
          id: id,
          name: name,
          city: city,
          address: address,
          type: AttractionType.restaurant,
          images: images,
        );

  static RestaurantModel fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
        id: json["id"],
        name: json["name"],
        images: json["images"],
        city: json["city"],
        address: json["address"],
        phone: json["phone"],
        link: json["link"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "images": images,
      "city": city,
      "address": address,
      "phone": phone,
      "link": link,
      "type": type,
    };
  }
}
