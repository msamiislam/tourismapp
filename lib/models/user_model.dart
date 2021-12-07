import '../models/enums.dart';
import '../models/trip_model.dart';

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
  final List<TripModel> trips;

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
    required this.trips,
  });

  static bool isTourist(Map<String, dynamic> json) {
    return json["user_type"] == UserType.tourist;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'user_type': userType,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'blood_group': bloodGroup,
      'dob': dob.toString(),
      'gender': gender,
      'trips': trips.map((e) => e.toJson()).toList(),
    };
  }

  bool get isGuide => userType == UserType.guide;

  String get initials => firstName.substring(0, 1).toUpperCase() + lastName.substring(0, 1).toUpperCase();
}
