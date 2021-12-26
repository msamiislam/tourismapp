class ContactModel {
  final String name;
  final String number;

  const ContactModel({required this.name, required this.number});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "number": number,
    };
  }

  static ContactModel fromJson(Map<String, dynamic> json) {
    return ContactModel(name: json['name'], number: json['number']);
  }
}
