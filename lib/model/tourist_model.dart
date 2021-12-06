import 'package:tourismapp/model/hotel_model.dart';
import 'package:tourismapp/model/mall_model.dart';
import 'package:tourismapp/model/restaurant_model.dart';
import 'package:tourismapp/model/trip_model.dart';
import 'package:tourismapp/model/user_model.dart';

import 'enums.dart';

class TouristModel extends UserModel {
  final List<RestaurantModel> favRestaurant;
  final List<MallModel> favMall;
  final List<HotelModel> favHotels;

  TouristModel({
    required String id,
    required String imageUrl,
    required String firstName,
    required String lastName,
    required String email,
    required String bloodGroup,
    required String phone,
    required String address,
    required DateTime dob,
    required String gender,
    List<TripModel> trips = const [],
    this.favRestaurant = const [],
    this.favMall = const [],
    this.favHotels = const [],
  }) : super(
          id: id,
          imageUrl: imageUrl,
          userType: UserType.tourist,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          address: address,
          bloodGroup: bloodGroup,
          dob: dob,
          gender: gender,
          trips: trips,
        );

  static TouristModel fromJson(Map<String, dynamic> json) {
    return TouristModel(
      id: json['id'],
      imageUrl: json["image_url"],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      bloodGroup: json['blood_group'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      trips: ((json['trips'] as List?) ?? []).map((e) => TripModel.fromJson(e)).toList(),
      favRestaurant: ((json["fav_restaurants"] as List?) ?? []).map((e) => RestaurantModel.fromJson(e)).toList(),
      favMall: ((json['fav_malls'] as List?) ?? []).map((e) => MallModel.fromJson(e)).toList(),
      favHotels: ((json['fav_hotels'] as List?) ?? []).map((e) => HotelModel.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'fav_restaurants': favRestaurant.map((e) => e.toJson()).toList(),
      'fav_malls': favMall.map((e) => e.toJson()).toList(),
      'fav_hotels': favHotels.map((e) => e.toJson()).toList(),
    };
  }
}
