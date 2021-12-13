class ActivityModel {
  DateTime? _time;
  String? _description;

  DateTime? get time => _time;

  String? get description => _description;

  ActivityModel();

  void updateTime(DateTime? time) {
    print(time);
    _time = time;
  }

  void updateDescription(String? description) => _description = description;

  static ActivityModel fromJson(Map<String, dynamic> json) {
    return ActivityModel()
      ..updateTime(json["time"] != null ? DateTime.parse(json["time"]) : null)
      ..updateDescription(json["description"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time?.toString(),
      "description": description,
    };
  }
}
