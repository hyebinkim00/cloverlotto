import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../config/route_names.dart';
import '../controller/self_controller.dart';

class SelfPage extends GetView<SelfController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backKey,
      child: Scaffold(
          body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity, // 전체 화면을 채우도록 설정
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // 사용자가 추가하게 하려고 햇는데 한번에 보여주는 걸로 바꿔함
              // 핸드폰 화면 크기마다 다르ㄴ게 나오는거 고치기
              // Widget Controller에서 빼기

              Obx(
                () => Container(
                  // height: MediaQuery.of(context).size.height * 0.8, // 화면 높이에 맞게 동적으로 설정
                  height: 650,
                  width: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                   // itemCount: controller.widgets.length,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return controller.widgets[index];
                    },
                  ),
                ),
              ),
              TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.deepOrangeAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // controller.saveList();
                    controller.listCon();
                    //      Get.toNamed(RouteNames.MYPAGE);
                  },
                  child: Text('확인하기')),
              // Obx(() => Text('${controller.dblist}'))
            ],
          ),
        ),
      )),
    );
  }

  void showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an option'),
          content: Column(
            children: [
              ListTile(
                title: Text('Option 1'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Option 2'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Option 3'),
                onTap: () {
                  // 다이어로그 닫음
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _backKey() async {
    // Get.delete<SelfController>();
    return true;
  }
}
