class GuideModel {
  final String uid;
  final String imgUrl;
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String address;
  final String bloodGroup;
  final String dob;
  final String gender;
  final String city;
  final String state;
  final String companyName;
  final List<String> services;
  final List<String> trip;
  final int totalTTrips;


  GuideModel({
    required this.uid,
    required this.imgUrl,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.address,
    required this.bloodGroup,
    required this.dob,
    required this.gender,
    required this.city,
    required this.state,
    required this.companyName,
    required this.services,
    required this.trip,
    required this.totalTTrips,
  });

  static fromJson(Map<String, dynamic> json) => GuideModel(
    uid: json["uid"],
    imgUrl: json["imgUrl"],
    fName: json["fName"],
    lName: json["lName"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    bloodGroup: json["bloodGroup"],
    dob: json["dob"],
    gender: json["gender"],
    city: json["city"],
    state: json["state"],
    companyName: json["companyName"],
    services: List<String>.from(json["services"].map((x) => x)),
    trip: List<String>.from(json["trip"].map((x) => x)),
    totalTTrips: json["totalTTrips"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "imgUrl": imgUrl,
    "fName": fName,
    "lName": lName,
    "email": email,
    "phone": phone,
    "address": address,
    "bloodGroup": bloodGroup,
    "dob": dob,
    "gender": gender,
    "city": city,
    "state": state,
    "companyName": companyName,
    "services": List<dynamic>.from(services.map((x) => x)),
    "trip": List<dynamic>.from(trip.map((x) => x)),
    "totalTTrips": totalTTrips,
  };
}