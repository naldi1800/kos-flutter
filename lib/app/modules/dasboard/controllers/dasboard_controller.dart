import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kos_kosan/app/MainController.dart';


class DasboardController extends GetxController {
  var showSearchBar = false.obs;
  late ScrollController scrollController;

  var categorySelected = 0.obs;
  late RxSet<int> favoriteSelected;

  var boardingHouses = [].obs;

  late TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    searchController = TextEditingController();
    _loadFavorite();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    searchController.dispose();
  }

  _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getStringList('favorite');
    if (favorite != null) {
      favoriteSelected = favorite.map((e) => int.parse(e)).toSet().obs;
    } else {
      favoriteSelected = <int>{}.obs;
    }
  }

  _saveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite', favoriteSelected.map((e) => e.toString()).toList());
  }

  Stream<List<dynamic>> getBoardingHouses() async* {
    await MainController.loadSavedUrl();
    final response = await http.get(Uri.parse(
        '${MainController.apiUrl}/api/boarding-house-all/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      for (var element in data) {
        element['favorit'] = favoriteSelected.contains(element['id']);
      }
      boardingHouses.value = data;
      yield data;
    } else {
      boardingHouses.value = [];
      yield [];
    }
  }

  void toggleFavorite(int id) {
    if (favoriteSelected.contains(id)) {
      favoriteSelected.remove(id);
    } else {
      favoriteSelected.add(id);
    }
    _saveFavorite();
  }
}

