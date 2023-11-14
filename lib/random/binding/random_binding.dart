import 'package:cloverlotto/random/controller/random_controller.dart';
import 'package:get/get.dart';

class RandomBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RandomController>(() => RandomController());
  }

}