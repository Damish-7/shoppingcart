// lib/app/services/api_service.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import 'storage_service.dart';

class ApiService extends GetxService {

  Map<String, String> get _headers {
    final token = Get.find<StorageService>().token;
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final res = await http.get(
      Uri.parse('${AppConfig.baseUrl}/$endpoint'),
      headers: _headers,
    );
    return _parse(res);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse('${AppConfig.baseUrl}/$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _parse(res);
  }

  Map<String, dynamic> _parse(http.Response res) {
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode >= 400) {
      throw data['message'] ?? 'Something went wrong';
    }
    return data;
  }
}