import 'package:cloverlotto/mypage/controller/mypage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/selfnum.dart';

class MyPage extends GetView<MyPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => ListView.builder(
          itemCount: controller.list.length,
          itemBuilder: (BuildContext context, int index){
            return Center(
               child: Text(('${controller.list[index].serial}')),
            );
          })
      ),
    ));
  }
}
