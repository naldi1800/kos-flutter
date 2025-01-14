import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/menuitem_controller.dart';
import 'package:kos_kosan/app/routes/app_pages.dart';

class MenuitemView extends GetView<MenuitemController> {
  const MenuitemView({super.key});
  @override
  Widget build(BuildContext context) {
    // print("Hay");
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
          backgroundColor: const Color(0xFF1A1A2E),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            Get.parameters['gender'] != null
                ? "Kosan type: ${Get.parameters['gender']}"
                : "Search",
            style: const TextStyle(
                color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () => Get.back(),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: StreamBuilder(
                stream:
                    controller.getBoardingHouses( Get.parameters['gender'] != null ? '${Get.parameters['gender']}' : ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  } else {
                    // return Obx(() {
                    print("Data From view: ${snapshot.data}");
                    if (snapshot.data != null) {
                      var datas = snapshot.data!;
                      // print(datas[0]['gender_restriction']);
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: datas.length,
                        itemBuilder: (context, index) {
                          var rooms = datas[index]['rooms']
                              .map((room) => {
                                    'id': room['id'],
                                    'availability': room['availability'],
                                  })
                              .toList();
                          var availableRooms = rooms
                              .where((room) => room['availability'] == 1)
                              .toList()
                              .length;
                          // print("Gambar");
                          // print(datas[index]['image']);
                          // print(datas[index]['image'][0]['url']);
                          return _buildBoardingHouseCard(
                            id: datas[index]['id'],
                            title: datas[index]['name'],
                            location: datas[index]['address'],
                            availability:
                                'Tersedia $availableRooms/${rooms.length}',
                            favoriteIconColor: (Random().nextDouble() < 0.5)
                                ? Colors.white
                                : Colors.orange,
                            imageUrl: datas[index]['image'][0]['url'],
                          );
                        },
                      );
                    } else {
                      return Container(
                        child: const Text("Data Kos Kosan Kosong"),
                      );
                    }
                    // });
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildBoardingHouseCard({
    required int id,
    required String title,
    required String location,
    required String availability,
    required Color favoriteIconColor,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.DETAIL, parameters: {"id": id.toString()}),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl, // Ganti dengan gambar Anda
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        availability,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Icon(Icons.favorite, color: favoriteIconColor)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
