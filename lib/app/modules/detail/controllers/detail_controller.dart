import 'package:get/get.dart';
import 'package:kos_kosan/app/MainController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailController extends GetxController {
  var imageView = 0.obs;
  var imageMax = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("Parameter ${Get.parameters}");
  }

  Stream<Map<String, dynamic>> getBoardingHouses(id) async* {
    await MainController.loadSavedUrl();
    final response = await http.get(Uri.parse(
        '${MainController.apiUrl}/api/boarding-house/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      yield data;
    } else {
      yield {};
    }
    // print(id);
    // final data = MainController.data.firstWhere((element) => element["id"] == int.parse(id));
    // yield data;
  }
}
