class TouristModel {
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

  static Map<String, dynamic> toJson(TouristModel touristModel){
    return {
      'fName':touristModel.fName,
      'lName':touristModel.lName,
      'email':touristModel.email,
      'phone':touristModel.phone,
      'address':touristModel.address,
      'bloodGroup':touristModel.bloodGroup,
      'dob':touristModel.dob,
      'gender':touristModel.gender,
      'trips':touristModel.trips,
      'favRestaurant':touristModel.favRestaurant,
      'favMall':touristModel.favMall,
      'favHotels':touristModel.favHotels,
    };
  }
}
