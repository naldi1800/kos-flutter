import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kos_kosan/app/routes/app_pages.dart';
import '../controllers/util_controller.dart';

class UtilView extends GetView<UtilController> {
  const UtilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'API Configuration',
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.apiUrlController,
              decoration: const InputDecoration(
                labelText: 'Enter API URL',
                labelStyle: TextStyle(color: Colors.orange),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.orange),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.checkApiConnection,
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 1, color: Colors.orange),
              ),
              child: const Text(
                'Connect',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isApiConnected.value
                    ? () {
                        // Navigate to Home
                        Get.offAndToNamed(Routes.DASBOARD);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 1, color: Colors.orange),
                ),
                child: Text(
                  'Go to Home',
                  style: TextStyle(color: !controller.isApiConnected.value ? Colors.orange : Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => controller.errorMessage.value.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : Container(),
            ),
            const SizedBox(height: 25),
            Obx(() {
              if (controller.isLoading.value) {
                return const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 5),
                    Text("Menyambungkan",
                        style: TextStyle(color: Colors.orange)),
                  ],
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
