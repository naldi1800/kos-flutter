import 'package:get/get.dart';

import '../controllers/menuitem_controller.dart';

class MenuitemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuitemController>(
      () => MenuitemController(),
    );
  }
}
