import 'package:cloverlotto/main/controller/main_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings{

  @override
  void dependencies() {
    // Get.lazyPut<MainController>(() => MainController());
    Get.put(MainController());
  }

}