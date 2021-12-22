import '../models/user_model.dart';
import 'enums.dart';

class TouristModel extends UserModel {
  final List<String> favAttractionsIds;

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
    List<String> tripsIds = const [],
    this.favAttractionsIds = const [],
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
          tripsIds: tripsIds,
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
      tripsIds: ((json['trips_ids'] as List?) ?? []).map((e) => e.toString()).toList(),
      favAttractionsIds: ((json['fav_attractions_ids'] as List?) ?? []).map((e) => e.toString()).toList(),
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
      'fav_attractions_ids': favAttractionsIds,
    };
  }

  void likeAttraction(String attractionId) {
    favAttractionsIds.add(attractionId);
  }

  void unlikeAttraction(String attractionId) {
    favAttractionsIds.remove(attractionId);
  }
}
