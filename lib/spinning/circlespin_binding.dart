import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'circlespin_controller.dart';

class CircleSpinBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CircleSpinController>(() => CircleSpinController());
  }

}