import 'package:get/get.dart';

import '../modules/dasboard/bindings/dasboard_binding.dart';
import '../modules/dasboard/views/dasboard_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/menuitem/bindings/menuitem_binding.dart';
import '../modules/menuitem/views/menuitem_view.dart';
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
      page: () => RoomView(
        boardingHouse: Get.arguments,
      ),
      binding: RoomBinding(),
    ),
    GetPage(
      name: _Paths.UTIL,
      page: () => const UtilView(),
      binding: UtilBinding(),
    ),
    GetPage(
      name: _Paths.DASBOARD,
      page: () => const DasboardView(),
      binding: DasboardBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.MENUITEM,
      page: () => const MenuitemView(),
      binding: MenuitemBinding(),
    ),
  ];
}
