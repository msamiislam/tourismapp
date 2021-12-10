import '../models/hotel_model.dart';
import '../models/trip_model.dart';
import '../models/user_model.dart';
import 'attraction_model.dart';
import 'enums.dart';

class TouristModel extends UserModel {
  final List<AttractionModel> favAttractions;

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
    this.favAttractions = const [],
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
      imageUrl: json["image_url"] ?? "",
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      bloodGroup: json['blood_group'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      trips: ((json['trips'] as List?) ?? []).map((e) => TripModel.fromJson(e)).toList(),
      favAttractions: ((json['fav_attractions'] as List?) ?? []).map((e) => HotelModel.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'fav_hotels': favAttractions.map((e) => e.toJson()).toList(),
    };
  }
}
