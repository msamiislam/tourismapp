import '../models/enums.dart';
import '../models/guide_model.dart';
import '../models/tourist_model.dart';

abstract class UserModel {
  final String id;
  final String imageUrl;
  final String userType;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String bloodGroup;
  final DateTime dob;
  final String gender;
  final List<String> tripsIds;

  UserModel({
    required this.id,
    required this.imageUrl,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.bloodGroup,
    required this.dob,
    required this.gender,
    required this.tripsIds,
  });

  static bool isTourist(Map<String, dynamic> json) {
    return json["user_type"] == UserType.tourist;
  }

  Map<String, dynamic> toJson() {
    if (userType == UserType.guide) {
      return (this as GuideModel).toJson();
    } else {
      return (this as TouristModel).toJson();
    }
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    String userType = json["user_type"];
    if (userType == UserType.guide) {
      return GuideModel.fromJson(json);
    } else {
      return TouristModel.fromJson(json);
    }
  }

  bool get isGuide => userType == UserType.guide;

  String get name =>
      firstName.substring(0, 1).toUpperCase() +
      firstName.substring(1).toLowerCase() + " " +
      lastName.substring(0, 1).toUpperCase() +
      lastName.substring(1).toLowerCase();

  String get initials => firstName.substring(0, 1).toUpperCase() + lastName.substring(0, 1).toUpperCase();
}
