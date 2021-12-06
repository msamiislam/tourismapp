import 'package:tourismapp/model/trip_model.dart';
import 'package:tourismapp/model/user_model.dart';

import 'enums.dart';

class GuideModel extends UserModel {
  final String city;
  final String state;
  final String companyName;
  final List<String> services;

  GuideModel({
    required String id,
    required String imageUrl,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String address,
    required String bloodGroup,
    required DateTime dob,
    required String gender,
    List<TripModel> trips = const [],
    required this.city,
    required this.state,
    required this.companyName,
    required this.services,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          userType: UserType.guide,
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

  static GuideModel fromJson(Map<String, dynamic> json) {
    return GuideModel(
      id: json["uid"],
      imageUrl: json["image_url"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      bloodGroup: json["blood_group"],
      dob: json["dob"],
      gender: json["gender"],
      city: json["city"],
      state: json["state"],
      companyName: json["company_name"],
      services: json["services"],
      trips: (json["trip"] as List).map((e) => TripModel.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      "city": city,
      "state": state,
      "company_name": companyName,
      "services": services,
    };
  }
}