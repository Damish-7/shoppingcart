// lib/app/services/storage_service.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  String? get token     => _prefs.getString('token');
  bool   get isLoggedIn => token != null;

  Future<void> saveToken(String t) => _prefs.setString('token', t);
  Future<void> clearToken()        => _prefs.remove('token');
}