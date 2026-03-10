// lib/app/bindings/initial_binding.dart
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(),         fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}