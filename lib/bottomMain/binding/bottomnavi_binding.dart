import 'package:cloverlotto/bottomMain/controller/bottom_controller.dart';
import 'package:get/get.dart';

class BottomNaviBinding extends Bindings{

  @override
  void dependencies() {
    // Get.lazyPut<MainController>(() => MainController());
    Get.put(BottomNaviController());
  }

}