// lib/app/controllers/product_controller.dart
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final _api = Get.find<ApiService>();

  final products  = <ProductModel>[].obs;
  final isLoading = false.obs;
  final error     = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    error.value     = '';
    try {
      final res  = await _api.get('products');
      final list = (res['data'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      products.assignAll(list);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}