import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kos_kosan/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boarding Houses'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.boardingHouses.isEmpty) {
          return const Center(child: Text('No Boarding Houses Found'));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchBoardingHouses,
          child: ListView.builder(
            itemCount: controller.boardingHouses.length,
            itemBuilder: (context, index) {
              final boardingHouse = controller.boardingHouses[index];
              return Card(
                child: ListTile(
                  title: Text(boardingHouse['name']),
                  subtitle: Text('Type: ${boardingHouse['gender_restriction']}'),
                  onTap: () {
                    // Get.to(() => BoardingHouseDetailsView(boardingHouse: boardingHouse));
                    Get.toNamed(Routes.ROOM, arguments: boardingHouse);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
