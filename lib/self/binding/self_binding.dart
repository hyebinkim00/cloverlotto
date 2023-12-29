import 'package:cloverlotto/self/controller/self_controller.dart';
import 'package:get/get.dart';

class SelfBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SelfController());
    // Get.lazyPut<SelfController>(() => SelfController());
  }

}