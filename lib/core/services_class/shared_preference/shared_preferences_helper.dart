import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _uidKey = 'uidKey';
  static const String _emailKey = 'emailKey';
  static const String _phoneKey = 'phoneKey';
  static const String _isWelcomeDialogShownKey = 'isWelcomeDialogShown';
  static const String _loginKey = 'loginKey';
  static const String _registrationCompleteKey = 'registrationCompleteKey';

  // Save uid
  static Future<void> saveUserUid(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, uid);
    await prefs.setBool(_loginKey, true);
  }

  // Save email and phone
  static Future<void> saveUserEmailandPhone(String email, String? phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_phoneKey, phone ?? '');
  }

  // Retrive email and phone
  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) ?? '';
  }
    static Future<String?> getUserPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneKey) ?? '';
  }

  // Save registration complete info
  static Future<void> saveRegistrationCompleteFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_registrationCompleteKey, true);
  }

  static Future<bool?> checkRegistrationCompleteFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_registrationCompleteKey) ?? false;
  }

  // Retrieve user uid
  static Future<String?> getUserUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_uidKey);
  }

  // Clear access token
  static Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_uidKey); // Clear the uid
    await prefs.remove(_loginKey); // Clear the login status
  }

  static Future<bool?> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  // Save the flag indicating the dialog has been shown
  static Future<void> setWelcomeDialogShown(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isWelcomeDialogShownKey, value);
  }

  // Retrieve the flag to check if the dialog has been shown
  static Future<bool> isWelcomeDialogShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isWelcomeDialogShownKey) ?? false;
  }
}
