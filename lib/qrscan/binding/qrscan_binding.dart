import 'package:cloverlotto/qrscan/controller/qrscan_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class QrscanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<QrscanController>(() => QrscanController());
  }
}