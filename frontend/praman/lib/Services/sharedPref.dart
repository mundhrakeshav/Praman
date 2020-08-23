import 'package:praman/Models/Organization.dart';
import 'package:praman/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefBase {}

class SharedPref implements SharedPrefBase {
  static SharedPreferences _prefs;

  static void initialiseStudent() {
    User.name = _prefs.getString("name");
    User.uid = _prefs.getString("uid");
    User.address = _prefs.getString("address");
    User.getUserData();
  }

  //TODO configure function for organization
  static void initialiseOrganization() {
    Organization.name = _prefs.getString("name");
    Organization.uid = _prefs.getString("uid");
    Organization.address = _prefs.getString("address");
  }

  static Future<bool> isStudentTokenPresent() async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString("studentToken");
    return token != null;
  }

  //TODO configure function for organization
  static Future<bool> isOrganizationTokenPresent() async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString("organizationToken");
    return token != null;
  }

  static Future<bool> setStudentData(
      String studentToken, String name, String uid, String address) async {
    _prefs = await SharedPreferences.getInstance();
    try {
      await _prefs.setString("studentToken", studentToken);
      await _prefs.setString("name", name);
      await _prefs.setString("uid", uid);
      await _prefs.setString("address", address);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //TODO configure function for organization
  static Future<bool> setOrganizationData(
    String organizationToken,
    String name,
    String uid,
    String address,
    String type,
  ) async {
    _prefs = await SharedPreferences.getInstance();
    try {
      await _prefs.setString("organizationToken", organizationToken);
      await _prefs.setString("name", name);
      await _prefs.setString("uid", uid);
      await _prefs.setString("address", address);
      await _prefs.setString("organizationType", type);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //TODO configure function for organization
  static Future<String> getOrganizationToken() async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString("organizationToken");
    return token;
  }

  static Future<String> getStudentToken() async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString("studentToken");
    return token;
  }

  static Future<bool> clearToken() async {
    _prefs = await SharedPreferences.getInstance();

    return _prefs.clear();
  }
}
