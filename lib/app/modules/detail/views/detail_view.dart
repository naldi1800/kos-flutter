import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Detail Kosan Exploler",
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: controller.getBoardingHouses(Get.parameters['id']),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                var data = snapshot.data!;
                controller.imageMax.value = data['image'].length;
                var rooms = data['rooms']
                    .map((room) => {
                          'id': room['id'],
                          'room_number': room['room_number'],
                          'size': room['size'],
                          'price': room['price'],
                          'availability': room['availability'],
                          'facilities': room['facilities']
                              .map((facility) => {
                                    'id': facility['id'],
                                    'facility': facility['facility']
                                  })
                              .toList(),
                          'description': room['description'],
                          'image': room['image'],
                        })
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data['name']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (controller.imageView.value > 0) {
                                controller.imageView.value--;
                              } else {
                                Get.snackbar(
                                  'Warning',
                                  'Tidak ada gambar sebelumnya',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.orange,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: (controller.imageView.value > 0)
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 3 * 1.5,
                            height: 175,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                data['image'][controller.imageView.value]
                                    ['url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller.imageView.value <
                                  controller.imageMax.value - 1) {
                                controller.imageView.value++;
                              } else {
                                Get.snackbar(
                                  'Warning',
                                  'Tidak ada gambar selanjutnya',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.orange,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: (controller.imageView.value <
                                      controller.imageMax.value - 1)
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '"${data['address']}"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ListView.separated(
                        separatorBuilder: (c, index) => const Divider(
                          color: Colors.orange,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          return _rooms(
                            id: rooms[index]['id'],
                            room: rooms[index],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox(
                  child: Text("Data Kos Kosan Kosong"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _rooms({
    required int id,
    required dynamic room,
  }) {
    var isAvailable = room['availability'] == 1;
    return StickyHeader(
      header: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nama Kamar : ${room['room_number']}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            Icon(
              isAvailable
                  ? Icons.meeting_room_sharp
                  : Icons.no_meeting_room_sharp,
              color: isAvailable ? Colors.green : Colors.red,
            )
          ],
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _roomDetail(room["id"], key: "Gambar", value: room['image']),
          _roomDetail(room["id"], key: "Ukuran", value: room['size']),
          _roomDetail(room["id"], key: "Harga", value: room['price']),
          _roomDetail(room["id"],
              key: "Fasilitas  ", value: room['facilities'], isFacility: true),
          _roomDetail(room["id"], key: "Deskripsi", value: room['description']),
        ],
      ),
    );
  }

  Widget _roomDetail(
  int id, {
  required String key,
  required dynamic value,
  bool isFacility = false,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$key : ",
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
      (!isFacility)
          ? (key == "Gambar")
              ? GestureDetector(
                  onTap: () {
                    _showImageDialog(value);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(value[0]['url']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Text(
                  "    ${value.toString()}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange[400],
                  ),
                )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.length,
              itemBuilder: (c, index) {
                var fac = value[index]['facility'];
                return Text(
                  "     - ${fac['name']}",
                  style: const TextStyle(color: Colors.orange),
                );
              },
            ),
      const SizedBox(height: 10),
    ],
  );
}

void _showImageDialog(List<dynamic> images) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.black.withOpacity(0.8),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 300,
        child: PageView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                images[index]['url'],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    ),
  );
}


  // Widget _roomDetail(
  //   int id, {
  //   required String key,
  //   required dynamic value,
  //   bool isFacility = false,
  // }) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "$key : ",
  //         style: const TextStyle(
  //           fontSize: 13,
  //           color: Colors.white,
  //         ),
  //       ),
  //       (!isFacility)
  //           ? Text(
  //               "    ${value.toString()}",
  //               overflow: TextOverflow.clip,
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.orange[400],
  //               ),
  //             )
  //           : ListView.builder(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: value.length,
  //               itemBuilder: (c, index) {
  //                 var fac = value[index]['facility'];
  //                 return Text(
  //                   "     - ${fac['name']}",
  //                   style: const TextStyle(color: Colors.orange),
  //                 );
  //               },
  //             ),
  //       const SizedBox(height: 10),
  //     ],
  //   );
  // }


}
