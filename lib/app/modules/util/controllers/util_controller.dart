import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UtilController extends GetxController {
  // Input controller
  final TextEditingController apiUrlController = TextEditingController();

  // Observables
  final isApiConnected = false.obs;
  final errorMessage = ''.obs;

  // Shared Preferences instance
  SharedPreferences? _prefs;

  // Simpan URL API secara global
  var apiUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedUrl(); // Load URL yang sudah disimpan
  }

  // Cek koneksi API
  void checkApiConnection() async {
    final url = apiUrlController.text;

    if (url.isEmpty) {
      errorMessage.value = 'Please enter a valid URL';
      isApiConnected.value = false;
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        isApiConnected.value = true;
        errorMessage.value = '';
        // Simpan URL dan beri tahu pengguna
        await _saveUrl(url);
        Get.snackbar('Success', 'Connected to API successfully!',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Invalid API response');
      }
    } catch (e) {
      isApiConnected.value = false;
      errorMessage.value = 'Failed to connect to API. Please check the URL.';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  // Simpan URL ke SharedPreferences
  Future<void> _saveUrl(String url) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString('apiUrl', url);
    apiUrl.value = url; // Update secara global
  }

  // Load URL dari SharedPreferences
  Future<void> _loadSavedUrl() async {
    _prefs ??= await SharedPreferences.getInstance();
    apiUrl.value = _prefs!.getString('apiUrl') ?? '';
    if (apiUrl.value.isNotEmpty) {
      apiUrlController.text = apiUrl.value;
    }
  }

  @override
  void onClose() {
    apiUrlController.dispose();
    super.onClose();
  }

  String rupiah(int $amount, {$prefix = 'Rp. '}) {
    return $prefix.number_format($amount, 0, ',', '.');
  }
}
