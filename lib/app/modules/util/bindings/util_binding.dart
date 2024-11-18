import 'package:get/get.dart';

import '../controllers/util_controller.dart';

class UtilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtilController>(
      () => UtilController(),
    );
  }
}
