import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kos_kosan/app/routes/app_pages.dart';

import '../controllers/dasboard_controller.dart';

class DasboardView extends GetView<DasboardController> {
  const DasboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Kosan Exploler",
            style:
                TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        leading: PopupMenuButton(
          icon: const Icon(Icons.menu, color: Colors.orange),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Umum',
              child: Text('Umum'),
            ),
            const PopupMenuItem(
              value: 'Khusus Putra',
              child: Text('Khusus Putra'),
            ),
            const PopupMenuItem(
              value: 'Khusus Putri',
              child: Text('Khusus Putri'),
            ),
          ],
          onSelected: (value) {
            if (value == 'Umum') {
              Get.toNamed(Routes.MENUITEM, parameters: {'gender': 'Bebas'});
            } else if (value == 'Khusus Putra') {
              Get.toNamed(Routes.MENUITEM,
                  parameters: {'gender': 'Khusus Putra'});
            } else if (value == 'Khusus Putri') {
              Get.toNamed(Routes.MENUITEM,
                  parameters: {'gender': 'Khusus Putri'});
            }
          },
        ),
        actions: [
          Obx(
            () => Visibility(
              visible: controller.showSearchBar.value,
              child: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.search, color: Colors.orange),
              ),
            ),
          ),
          // CircleAvatar(
          //   backgroundColor: Colors.orange,
          //   child: Icon(Icons.person, color: Colors.white),
          // ),
          // SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Temukan kos kosan\nsesuai keinginan Anda',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildSearchBar(),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.MENUITEM,
                              parameters: {'search': controller.searchController.text});
                        },
                        icon: const Icon(Icons.search, color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryButton(
                      0,
                      'Umum',
                      (controller.categorySelected.value == 0),
                    ),
                    _buildCategoryButton(
                      1,
                      'Khusus Putra',
                      (controller.categorySelected.value == 1),
                    ),
                    _buildCategoryButton(
                      2,
                      'Khusus Putri',
                      (controller.categorySelected.value == 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: StreamBuilder(
                    stream: controller.getBoardingHouses(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        );
                      } else {
                        return Obx(() {
                          // print(snapshot.data);
                          if (snapshot.data != null) {
                            var datas = snapshot.data!;
                            // print(datas[0]['gender_restriction']);

                            if (controller.categorySelected.value == 0) {
                              datas = datas
                                  .where((boardingHouse) =>
                                      boardingHouse['gender_restriction'] ==
                                      "Bebas")
                                  .toList();
                            } else if (controller.categorySelected.value == 1) {
                              datas = datas
                                  .where((boardingHouse) =>
                                      boardingHouse['gender_restriction'] ==
                                      "Khusus Putra")
                                  .toList();
                            } else if (controller.categorySelected.value == 2) {
                              datas = datas
                                  .where((boardingHouse) =>
                                      boardingHouse['gender_restriction'] ==
                                      "Khusus Putri")
                                  .toList();
                            }

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
                                          // 'size': room['size'],
                                          // 'price': room['price'],
                                          'availability': room['availability'],
                                          // 'facilities': room['facilities'].map((facility) => {
                                          //   'id': facility['id'],
                                          //   'facility': facility['facility']
                                          // }).toList(),
                                          // 'description': room['description']
                                        })
                                    .toList();
                                var availableRooms = rooms
                                    .where((room) => room['availability'] == 1)
                                    .toList()
                                    .length;
                                print("Gambar");
                                print(datas[index]['image']);
                                print(datas[index]['image'][0]['url']);
                                return _buildBoardingHouseCard(
                                  id: datas[index]['id'],
                                  title: datas[index]['name'],
                                  location: datas[index]['address'],
                                  availability:
                                      'Tersedia $availableRooms/${rooms.length}',
                                  favoriteIconColor:
                                      (Random().nextDouble() < 0.5)
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
                        });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A2E),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Exit',
          ),
        ],
        onTap: (index) {
          print(index);
          if (index == 1) {
            Get.offAndToNamed(Routes.UTIL);
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    // print(controller.showSearchBar.value);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        print('Notifikasi diterima: $notification');
        if (notification is ScrollUpdateNotification) {
          // print(notification.metrics.pixels);
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent) {
            controller.showSearchBar.value = false;
          } else {
            controller.showSearchBar.value = true;
          }
          // print(notification);
        }
        return true;
      },
      child: ListView(
        controller: controller.scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        shrinkWrap: true,
        children: [
          TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              hintText: 'Cari kos kosan Anda...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(int index, String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        controller.categorySelected.value = index;
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.orange : Colors.grey[400],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
                      // Container(
                      //   padding: const EdgeInsets.all(4),
                      //   decoration: BoxDecoration(
                      //     color: Colors.orange,
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: Icon(Icons.favorite, color: favoriteIconColor),
                      // ),
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
