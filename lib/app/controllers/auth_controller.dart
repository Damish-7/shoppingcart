// lib/app/controllers/auth_controller.dart
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthController extends GetxController {
  final _api     = Get.find<ApiService>();
  final _storage = Get.find<StorageService>();

  final user      = Rxn<UserModel>();
  final isLoading = false.obs;
  final error     = ''.obs;

  bool get isLoggedIn => user.value != null;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    error.value     = '';
    try {
      final res  = await _api.post('login', {
        'email':    email,
        'password': password,
      });
      final data = res['data'] as Map<String, dynamic>;
      await _storage.saveToken(data['token'] as String);
      user.value = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      Get.offAllNamed('/home');
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;
    error.value     = '';
    try {
      final res  = await _api.post('register', {
        'name':     name,
        'email':    email,
        'password': password,
      });
      final data = res['data'] as Map<String, dynamic>;
      await _storage.saveToken(data['token'] as String);
      user.value = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      Get.offAllNamed('/home');
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _storage.clearToken();
    user.value = null;
    Get.offAllNamed('/login');
  }
}