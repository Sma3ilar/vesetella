import 'package:pg_web/models/data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants/app_constants.dart';

class LocalStorage {
  LocalStorage._();

  static final LocalStorage _instance = LocalStorage._();

  static LocalStorage get instance => _instance;

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  dynamic getValue(String key) => _prefs?.get(key);

  Future<void> setValue(String key, dynamic value) async {
    if (_prefs == null) {
      throw Exception("SharedPreferencesService not initialized.");
    }

    if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw Exception("Unsupported value type");
    }
  }

  Future<void> removeValue(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> saveObject<T>(String key, T object) async {
    if (_prefs == null) {
      throw Exception("SharedPreferencesService not initialized.");
    }

    final String jsonString = jsonEncode(object);
    await _prefs!.setString(key, jsonString);
  }

  T? getObject<T>(String key, T Function(dynamic) fromJson) {
    final jsonString = _prefs?.getString(key);
    if (jsonString == null) return null;

    final dynamic jsonData = jsonDecode(jsonString);
    return fromJson(jsonData);
  }

  // ######################################################

  Future<void> setToken(String? token) async {
    if (_prefs != null) {
      await _prefs!.setString(AppConstants.keyToken, token ?? '');
    }
  }

  String getToken() => _prefs?.getString(AppConstants.keyToken) ?? '';

  void deleteToken() => _prefs?.remove(AppConstants.keyToken);

  Future<void> setRole(String? role) async {
    if (_prefs != null) {
      await _prefs!.setString(AppConstants.keyRole, role ?? '');
    }
  }

  String getRole() => _prefs?.getString(AppConstants.keyRole) ?? '';

  Future<void> setAuth(bool? isAuth) async {
    if (_prefs != null) {
      await _prefs!.setBool(AppConstants.keyIsAuth, isAuth ?? false);
    }
  }

  bool getIsAuth() => _prefs?.getBool(AppConstants.keyIsAuth) ?? false;

  Future<void> setIsViewedOnboarding(bool? boarded) async {
    if (_prefs != null) {
      await _prefs!.setBool(AppConstants.keyIsOnBoarded, boarded ?? false);
    }
  }

  bool getIsViewedOnboarding() =>
      _prefs?.getBool(AppConstants.keyIsOnBoarded) ?? false;

  // User data
  Future<void> setUserData(UserData userData) async {
    print('setUserData');
    await saveObject<UserData>(AppConstants.keyUser, userData);
  }

  Future<UserData?> getUserData() async {
    print('getUserData');
    return getObject<UserData>(
      AppConstants.keyUser,
      (json) => UserData.fromJson(json),
    );
  }

  void deleteUserData() => _prefs?.remove(AppConstants.keyUser);
  // Language storage

  Future<void> setLanguage(String code) async {
    if (_prefs != null) {
      await _prefs!.setString(AppConstants.keyAppLanguage, code);
    }
  }

  String get currentLanguage =>
      _prefs?.getString(AppConstants.keyAppLanguage) ?? 'ar';

  // Translation storage

  Map<String, String> get translations {
    final jsonString = _prefs?.getString(AppConstants.translationsKey);
    if (jsonString == null) return {};
    final decoded = json.decode(jsonString) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value.toString()));
  }

  Future<void> setTranslations(Map<String, dynamic> translations) async {
    await _prefs?.setString(
      AppConstants.translationsKey,
      json.encode(translations),
    );
  }

  String getCountryId() => _prefs?.getString(AppConstants.keyAppLanguage) ?? "";

  void logout() {
    deleteToken();
    setAuth(false);
    // deleteVisitorData();
    setRole('');
  }
}

/// Register SharedPreferencesService in DI (for GetIt)
/*void setupDI() {
  inject.registerLazySingleton(() => SharedPreferencesService());
}*/
