import 'package:get/get.dart';
// import 'package:kos_kosan/app/MainController.dart';

import '../controllers/dasboard_controller.dart';

class DasboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DasboardController>(
      () => DasboardController(),
    );
    // Get.lazyPut<MainController>(
    //   () => MainController(),
    // );
  }
}
