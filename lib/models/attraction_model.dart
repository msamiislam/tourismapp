import 'package:tourismapp/models/place_model.dart';
import 'package:tourismapp/models/restaurant_model.dart';

import 'hotel_model.dart';
import 'mall_model.dart';

abstract class AttractionModel {
  final String id;
  final String name;
  final String city;
  final String address;
  final String description;
  final double rating;
  final List<String> images;
  final String type;

  AttractionModel({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.description,
    required this.rating,
    required this.images,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    if (type == AttractionType.mall) {
      return (this as MallModel).toJson();
    } else if (type == AttractionType.hotel) {
      return (this as HotelModel).toJson();
    } else if (type == AttractionType.restaurant) {
      return (this as RestaurantModel).toJson();
    } else {
      return (this as PlaceModel).toJson();
    }
  }

  static AttractionModel fromJson(Map<String, dynamic> json) {
    String type = json["type"];
    if (type == AttractionType.mall) {
      return MallModel.fromJson(json);
    } else if (type == AttractionType.hotel) {
      return HotelModel.fromJson(json);
    } else if (type == AttractionType.restaurant) {
      return RestaurantModel.fromJson(json);
    } else {
      return PlaceModel.fromJson(json);
    }
  }
}

class AttractionType {
  static const List<String> values = ["Mall", "Hotel", "Restaurant", "Place"];
  static final String mall = values[0];
  static final String hotel = values[1];
  static final String restaurant = values[2];
  static final String place = values[3];
}
