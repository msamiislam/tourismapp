import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/guide_model.dart';
import '../models/tourist_model.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  static const String _isAppOpenedKey = "is_app_opened";
  static const String _userKey = "user";
  static final GetStorage _storage = GetStorage();
  UserModel? _user;
  bool _isAppOpened = false;

  UserModel? get user => _user;

  bool get hasUserData => _user != null;

  bool get isAppOpened => _isAppOpened;

  bool? get isTourist => _user != null ? !_user!.isGuide : null;

  LoginController() {
    read();
  }

  void read() {
    Map json = _storage.read<Map>(_userKey) ?? {};
    if (json.isNotEmpty && json is Map<String, dynamic>) {
      _user = UserModel.isTourist(json) ? TouristModel.fromJson(json) : GuideModel.fromJson(json);
    }
    _isAppOpened = _storage.read<bool>(_isAppOpenedKey) ?? false;
  }

  Future<void> write() async {
    await _storage.write(_userKey, _user?.toJson());
    await _storage.write(_isAppOpenedKey, _isAppOpened);
  }

  void login(UserModel user) {
    _user = user;
    write();
    update();
  }

  void logout() {
    _user = null;
    write();
    update();
  }

  void updateUser(UserModel? user) {
    _user = user;
    write();
    update();
  }

  void appOpened() {
    _isAppOpened = true;
    write();
  }
}
