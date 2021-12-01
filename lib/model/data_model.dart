class DataModel{
  String name;
  String img;
  int price;
  int people;
  int star;
  String description;
  String location;

  DataModel({
    required this.name,
    required this.img,
    required this.price,
    required this.people,
    required this.star,
    required this.description,
    required this.location,
  });

  factory DataModel.fromjson(Map<String, dynamic> json){
    return DataModel(
      name: json["name"],
      img: json["img"],
      price: json["price"],
      people: json["people"],
      star: json["star"],
      description: json["description"],
      location: json["location"],
    );
  }
}