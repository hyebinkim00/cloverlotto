import 'package:cloverlotto/random/controller/random_controller.dart';
import 'package:cloverlotto/self/controller/self_controller.dart';
import 'package:get/get.dart';

class SelfBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SelfController>(() => SelfController());
  }

}