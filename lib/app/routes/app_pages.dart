import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/room/bindings/room_binding.dart';
import '../modules/room/views/room_view.dart';
import '../modules/util/bindings/util_binding.dart';
import '../modules/util/views/util_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.UTIL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ROOM,
      page: () =>  RoomView(
        boardingHouse: Get.arguments,
      ),
      binding: RoomBinding(),
    ),
    GetPage(
      name: _Paths.UTIL,
      page: () => const UtilView(),
      binding: UtilBinding(),
    ),
  ];
}
