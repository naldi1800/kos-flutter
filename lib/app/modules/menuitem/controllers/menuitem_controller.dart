import 'package:get/get.dart';
import 'package:kos_kosan/app/MainController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuitemController extends GetxController {
  late RxSet<int> favoriteSelected;

  var boardingHouses = [].obs;

  Stream<List<dynamic>> getBoardingHouses(type) async* {
    await MainController.loadSavedUrl();
    var response;
    if (type == '') {
      type = Get.parameters['search'];
      response = await http.get(Uri.parse(
          '${MainController.apiUrl}/api/boarding-house-where-search/$type'));
    } else {
      response = await http.get(Uri.parse(
          '${MainController.apiUrl}/api/boarding-house-where-type/$type'));
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      boardingHouses.value = data;
      yield data;
    } else {
      boardingHouses.value = [];
      yield [];
    }
  }
}
