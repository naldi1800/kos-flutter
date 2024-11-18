import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/room_controller.dart';

class RoomView extends GetView<RoomController> {
  final Map<String, dynamic> boardingHouse;
  const RoomView({super.key, required this.boardingHouse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(boardingHouse['name']),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text('Peraturan: ${boardingHouse['rules']}'),
          Text('Batas Malam: ${boardingHouse['curfew']}'),
          const SizedBox(height: 10),
          const Text(
            'Kamar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ...boardingHouse['rooms'].map<Widget>((room) {
            return Card(
              child: ListTile(
                title: Text('Ukuran Kamar: ${room['size']}'),
                subtitle: Text('Harga Sewa: ${controller.rupiah(room['price'])}'),
                isThreeLine: true,
                trailing: room['availability'] == 1
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.cancel, color: Colors.red),
                onTap: () {
                  Get.defaultDialog(
                    title: 'Room Details',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${room['description']}'),
                        const SizedBox(height: 10),
                        const Text('Facilities:'),
                        ...room['facilities'].map<Widget>((facility) {
                          return Text('- ${facility['facility']['name']}');
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
