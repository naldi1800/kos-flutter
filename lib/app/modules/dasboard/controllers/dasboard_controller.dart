import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kos_kosan/app/MainController.dart';
import 'package:kos_kosan/app/modules/util/controllers/util_controller.dart';

class DasboardController extends GetxController {
  var showSearchBar = false.obs;
  late ScrollController scrollController;

  // final mainController = Get.find<MainController>();
  final utilController = Get.find<UtilController>();

  var categorySelected = 0.obs;
  late RxMap<int, bool> favoriteSelected;

  var boardingHouses = [].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Stream<List<dynamic>> getBoardingHouses() async* {
    await MainController.loadSavedUrl();
    final response = await http.get(Uri.parse(
        '${MainController.apiUrl}/api/boarding-house-all/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      boardingHouses.value = data;

      // getFavorit();
     
      // print(favoriteSelected);
      yield data;
    } else {
      boardingHouses.value = [];
      yield [];
    }
    // print("Boarding Houses: $boardingHouses");
  }

  // get favorit from shared preferences
  // Future<void> getFavorit() async {
  //   favoriteSelected = RxMap<int, bool>.from(
  //     boardingHouses.value.asMap().map<int, Future<bool>>(
  //       (index, value) => MapEntry(
  //         value['id'] as int,
  //         MainController.loadSavedBool(value['id'].toString()),
  //       ),
  //     ),
  //   );
  //   print(favoriteSelected);
  // }

  // Future<void> getFavorit() async {
  //    favoriteSelected = RxMap<int, bool>.from(
  //       boardingHouses.value.asMap().map<int, Future<bool>>(
  //         (index, value) => MapEntry(
  //           value['id'] as int,
  //            MainController.loadSavedBool(value['id'].toString()),
  //         ),
  //       ),
  //     );
  //     print(favoriteSelected);
  // }
}
