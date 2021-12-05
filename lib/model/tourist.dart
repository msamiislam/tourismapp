class TouristModel {
  final String uid;
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String address;
  final String bloodGroup;
  final DateTime dob;
  final String gender;
  final List<String> trips;
  final List<String> favRestaurant;
  final List<String> favMall;
  final List<String> favHotels;

  TouristModel({
    required this.uid,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.address,
    required this.bloodGroup,
    required this.dob,
    required this.gender,
    required this.trips,
    required this.favRestaurant,
    required this.favMall,
    required this.favHotels,
  });

  static TouristModel fromJson(Map<String, dynamic> json) {
    return TouristModel(
      uid: json['uid'],
      fName: json['fName'],
      lName: json['lName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      bloodGroup: json['bloodGroup'],
      dob: json['dob'],
      gender: json['gender'],
      trips: json['trips'],
      favRestaurant: json['favRestaurant'],
      favMall: json['favMall'],
      favHotels: json['favHotels'],
    );
  }

  Map<String, dynamic> toJson( ){
    return {
      'uid':uid,
      'fName':fName,
      'lName':lName,
      'email':email,
      'phone':phone,
      'address':address,
      'bloodGroup':bloodGroup,
      'dob':dob,
      'gender':gender,
      'trips':trips,
      'favRestaurant':favRestaurant,
      'favMall':favMall,
      'favHotels':favHotels,
    };
  }
}
