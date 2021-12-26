import '../models/user_model.dart';
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
    List<String> tripsIds = const [],
    required this.city,
    required this.state,
    required this.companyName,
    this.services = const [],
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
          tripsIds: tripsIds,
        );

  static GuideModel fromJson(Map<String, dynamic> json) {
    return GuideModel(
      id: json["id"],
      imageUrl: json["image_url"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      bloodGroup: json["blood_group"],
      dob: DateTime.parse(json["dob"]),
      gender: json["gender"],
      tripsIds: ((json['trips_ids'] as List?) ?? []).map((e) => e.toString()).toList(),
      city: json["city"],
      state: json["state"],
      companyName: json["company_name"],
      services: ((json['services'] as List?) ?? []).map((e) => e.toString()).toList(),
    );
  }

  @override
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
      'trips_ids': tripsIds,
      "city": city,
      "state": state,
      "company_name": companyName,
      "services": services,
    };
  }
}