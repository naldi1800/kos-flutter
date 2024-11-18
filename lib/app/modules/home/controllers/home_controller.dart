import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kos_kosan/app/modules/util/controllers/util_controller.dart';

class HomeController extends GetxController {
  // Observable list untuk menyimpan data boarding house

  final utilController = Get.find<UtilController>();
  var boardingHouses = [].obs;
  var isLoading = true.obs;

  // Dapatkan URL API
  String get apiUrl => utilController.apiUrl.value;
  // get data => utilController.data.value;

  @override
  void onInit() {
    super.onInit();
    print('API URL from Home: $apiUrl');
    fetchBoardingHouses();
  }

  Future<void> fetchBoardingHouses() async {
    // isLoading(true);
    // boardingHouses.value = data;
    // isLoading(false);

    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('$apiUrl/api/boarding-house-all'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body)['data'];
        boardingHouses.value = data;
      } else {
        Get.snackbar('Error', 'Failed to fetch data from API');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
