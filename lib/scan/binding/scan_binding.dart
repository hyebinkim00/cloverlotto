import 'package:cloverlotto/random/controller/random_controller.dart';
import 'package:cloverlotto/scan/controller/scan_controller.dart';
import 'package:cloverlotto/self/controller/self_controller.dart';
import 'package:get/get.dart';

class ScanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ScanController>(() => ScanController());
  }

}