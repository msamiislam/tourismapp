abstract class Gender {
  static const List<String> values = ["Male", "Female", "None"];
  static final String male = values[0];
  static final String female = values[1];
  static final String none = values[2];
}

abstract class BloodGroup {
  static const List<String> values = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  static final String aPositive = values[0];
  static final String aNegative = values[1];
  static final String bPositive = values[2];
  static final String bNegative = values[3];
  static final String oPositive = values[4];
  static final String oNegative = values[5];
  static final String abPositive = values[6];
  static final String abNegative = values[7];
}

class UserType {
  static const List<String> values = ["Tourist", "Guide"];
  static final String tourist = values[0];
  static final String guide = values[1];
}
