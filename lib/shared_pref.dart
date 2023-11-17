import 'package:aneka/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUser {
  // static const String kToken = 'kToken';
  static void saveAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'kToken';
    final value = FFAppState().authtoken;
    prefs.setString(key, value);
    print('save : $value, $key');
  }
  static void saveEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'kEmail';
    final value = FFAppState().email;
    prefs.setString(key, value);
    print('save : $value');
  }
  static void savePassword() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'kPassword';
    final value = FFAppState().password;
    prefs.setString(key, value);
    print('save : $value');
  }
  static void saveUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'kUserName';
    final value = FFAppState().userName;
    prefs.setString(key, value);
    print('save : $value');
  }
  static void saveRole() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'kRole';
    final value = FFAppState().role;
    prefs.setString(key, value);
    print('save : $value');
  }
  static void saveNoTelp() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'kNoTelp';
    final value = FFAppState().noTelp;
    prefs.setString(key, value);
    print('save : $value');
  }
  static void saveIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'kIdUser';
    final value = FFAppState().idUsers;
    prefs.setString(key, value);
    print('save : $value');
  }
}

class GetUser {
  static const String kName = "userName";
  static const String kEmail = "email";
  static const String kPassword = "password";
  static const String kRole = "role";
  static const String kIdUser = "id";
  static const String kAuthToken = "authToken";
  static const String kNoTelp = "noTelp";
  static void updateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? kToken = prefs.getString('kToken');
    final String? kEmail = prefs.getString('kEmail');
    final String? kPassword = prefs.getString('kPassword');
    final String? kUserName = prefs.getString('kUserName');
    final String? kRole = prefs.getString('kRole');
    final String? kIdUser = prefs.getString('kIdUser');
    final String? kNoTelp = prefs.getString('kNoTelp');
    //Update Local to FFAppState
    FFAppState().update(() {
      FFAppState().authtoken = kToken!;
      FFAppState().userName = kUserName!;
      FFAppState().noTelp = kNoTelp!;
      FFAppState().role = kRole!;
      FFAppState().idUsers = kIdUser!;
      FFAppState().email = kEmail!;
      FFAppState().password = kPassword!;
    });
  }
}

class RemoveUser {
  static void removeUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('kToken');
    pref.remove('kEmail');
    pref.remove('kPassword');
    pref.remove('kUserName');
    pref.remove('kRole');
    pref.remove('kIdUser');
    pref.remove('kNoTelp');
  }
}