import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _tokenKey = 'token';
  static const _uidKey = 'uid';
  static SharedPreferences? _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future saveToken(String token) async => _prefs?.setString(_tokenKey, token);
  static Future saveUID(String uid) async => _prefs?.setString(_uidKey, uid);

  static String? getUID() => _prefs?.getString(_uidKey);
  static String? getToken() => _prefs?.getString(_tokenKey);

  static Future<void> clear() async => await _prefs?.clear();
}
