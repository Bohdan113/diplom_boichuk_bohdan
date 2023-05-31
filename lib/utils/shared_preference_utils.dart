// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static final SharedPreferenceUtils _instance = SharedPreferenceUtils._internal();

  factory SharedPreferenceUtils() {
    return _instance;
  }

  SharedPreferenceUtils._internal();

  static String get authenticationToken => 'authenticationToken';

  static String get userNumber => 'userNumber';

  static String get userID => 'userId';

  static String get update => 'update';

  static String get locationPermission => 'locationPermission';

  Future<bool?> getUpdate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(update);
  }

  Future<bool?> setUpdate(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(update, value);
  }

  ///Authentication Section
  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(authenticationToken);
  }

  Future<String?> getNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userNumber);
  }

  Future<bool> saveToken({
    required String token,
    required String number,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(userNumber, number);
    return await preferences.setString(authenticationToken, token);
  }

  Future<bool> saveUserId({required int userId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(userID, userId);
  }

  Future<int?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(userID);
  }

  Future<bool> deleteToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(userNumber);
    return await preferences.remove(authenticationToken);
  }

  ///Location save persmiossion
  Future<bool?> getLocationPermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(locationPermission);
  }

  Future<bool?> saveLocationPermission({required bool locationPermissions}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(locationPermission, locationPermissions);
  }
}
