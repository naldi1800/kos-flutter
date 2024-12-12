import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kos_kosan/app/MainController.dart';

class UtilController extends GetxController {
  // Input controller
  final TextEditingController apiUrlController = TextEditingController();

  // Observables
  final isApiConnected = false.obs;
  final errorMessage = ''.obs;

  var apiUrl = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    apiUrlController.text = await MainController.loadSavedUrl();
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
      if (await MainController.checkApiConnection(url)) {
        isApiConnected.value = true;
        errorMessage.value = '';
        // Simpan URL dan beri tahu pengguna
        await MainController.saveUrl(url);
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


  @override
  void onClose() {
    apiUrlController.dispose();
    super.onClose();
  }

  String rupiah(int $amount, {$prefix = 'Rp. '}) {
    return $prefix.number_format($amount, 0, ',', '.');
  }
}
