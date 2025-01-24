import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_response.dart';
import 'preference_key.dart';

/// Helper class to store data in preference storage
class PreferencesHelper extends GetxService {
  late Future<SharedPreferences> sharedPreferences;

  @override
  void onInit() {
    super.onInit();
    sharedPreferences = SharedPreferences.getInstance();
  }

  /// Retrieve status user login status
  Future<bool> get isLoggedIn async {
    final prefs = await sharedPreferences;
    return prefs.getBool(PreferenceKey.prefIsLoggedIn) ?? false;
  }

  /// Retrieve [bool] status user admin when logged in
  Future<bool> get userLoginAdmin async {
    final prefs = await sharedPreferences;
    final userAdmin = prefs.getBool(PreferenceKey.prefUserRoleAdmin) ?? false;
    return userAdmin;
  }

  /// Retrieve [String] name when logged in
  Future<String> get authToken async {
    final prefs = await sharedPreferences;
    final userName = prefs.getString(PreferenceKey.prefAuthToken) ?? "";
    return "Bearer $userName";
  }

  /// Retrieve [String] name when logged in
  Future<String> get userLoggedIn async {
    final prefs = await sharedPreferences;
    final userName = prefs.getString(PreferenceKey.prefUserName) ?? "";
    return userName;
  }

  /// Retrieve [String] user img url when logged in
  Future<String> get userPicture async {
    final prefs = await sharedPreferences;
    final userPic = prefs.getString(PreferenceKey.prefUserPic) ?? "";
    return userPic;
  }

  /// Retrieve [int] id when logged in
  Future<int> get userLoggedInId async {
    final prefs = await sharedPreferences;
    final userId = prefs.getInt(PreferenceKey.prefUserId) ?? -1;
    return userId;
  }

  /// Save data [LoginResponse] id to preference storage
  Future<void> setUserLoggedIn(LoginResponse user) async {
    final prefs = await sharedPreferences;
    await prefs.setBool(PreferenceKey.prefIsLoggedIn, true);
    await prefs.setString(PreferenceKey.prefUserName, user.citizenName);
    await prefs.setInt(PreferenceKey.prefUserId, user.citizenId);
    bool userRoleAdmin = user.roleId == 99;
    await prefs.setBool(PreferenceKey.prefUserRoleAdmin, userRoleAdmin);
    await prefs.setString(PreferenceKey.prefAuthToken, user.token);
    if (user.profilePictureUrl != null) setUserPicture(user.profilePictureUrl!);
  }

  /// Save data [String] img url to preference storage
  Future<void> setUserPicture(String url) async {
    final prefs = await sharedPreferences;
    await prefs.setString(PreferenceKey.prefUserPic, url);
  }

  /// Remove data preference storage
  Future<void> setUserLoggedOut() async {
    final prefs = await sharedPreferences;
    await prefs.remove(PreferenceKey.prefIsLoggedIn);
    await prefs.remove(PreferenceKey.prefUserRoleAdmin);
    await prefs.remove(PreferenceKey.prefUserPic);
    await prefs.remove(PreferenceKey.prefUserName);
    await prefs.remove(PreferenceKey.prefUserId);
    await prefs.remove(PreferenceKey.prefAuthToken);
  }
}
