import 'package:cloverlotto/mynum/controller/mynum_controller.dart';
import 'package:cloverlotto/mypage/controller/mypage_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class MyNumBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyNumController>(() => MyNumController());
  }
}