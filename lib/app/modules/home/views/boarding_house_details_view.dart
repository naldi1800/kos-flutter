import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardingHouseDetailsView extends StatelessWidget {
  final Map<String, dynamic> boardingHouse;

  const BoardingHouseDetailsView({super.key, required this.boardingHouse});

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
          Text('Rules: ${boardingHouse['rules']}'),
          Text('Curfew: ${boardingHouse['curfew']}'),
          const SizedBox(height: 10),
          const Text(
            'Rooms',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ...boardingHouse['rooms'].map<Widget>((room) {
            return Card(
              child: ListTile(
                title: Text('Room Size: ${room['size']}'),
                subtitle: Text('Price: ${room['price']}'),
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
                        Text('Facilities:'),
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
