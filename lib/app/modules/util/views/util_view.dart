import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kos_kosan/app/routes/app_pages.dart';
import '../controllers/util_controller.dart';

class UtilView extends GetView<UtilController> {
  const UtilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Configuration'),
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
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.checkApiConnection,
              child: const Text('Connect'),
            ),
            const SizedBox(height: 16),
            Obx(() => ElevatedButton(
                  onPressed: controller.isApiConnected.value
                      ? () {
                          // Navigate to Home
                          Get.offAndToNamed(Routes.DASBOARD);
                        }
                      : null,
                  child: const Text('Go to Home'),
                )),
            Obx(() => controller.errorMessage.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }
}
