class GuideModel {
  GuideModel({
    required this.uid,
    required this.imgUrl,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.address,
    required this.bloodGroup,
    required this.dob
    ,
    required this.gender,
    required this.city,
    required this.state,
    required this.companyName,
    required this.services,
    required this.trip,
    required this.totalTTrips,
  });

  String uid;
  String imgUrl;
  String fName;
  String lName;
  String email;
  String phone;
  String address;
  String bloodGroup;
  String dob;
  String gender;
  String city;
  String state;
  String companyName;
  List<String> services;
  List<String> trip;
  String totalTTrips;

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

  static Map<String, dynamic> toJson(GuideModel guideModel) => {
    "uid": guideModel.uid,
    "imgUrl": guideModel.imgUrl,
    "fName": guideModel.fName,
    "lName": guideModel.lName,
    "email":guideModel. email,
    "phone": guideModel.phone,
    "address": guideModel.address,
    "bloodGroup": guideModel.bloodGroup,
    "dob": guideModel.dob,
    "gender": guideModel.gender,
    "city": guideModel.city,
    "state": guideModel.state,
    "companyName": guideModel.companyName,
    "services": List<dynamic>.from(guideModel.services.map((x) => x)),
    "trip": List<dynamic>.from(guideModel.trip.map((x) => x)),
    "totalTTrips": guideModel.totalTTrips,
  };
}