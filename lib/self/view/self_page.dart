import 'package:cloverlotto/main/controller/main_controller.dart';
import 'package:cloverlotto/sqllite/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../config/route_names.dart';
import '../controller/self_controller.dart';

class SelfPage extends GetView<SelfController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width, // 전체 화면을 채우도록 설정
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //회차 선택
            TextButton(
              onPressed: () {
                showOptionDialog(context);
              },
              child: Text(''+'회'),
            ),
            Text('번호를 입력하세요!'),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 10, // 가로 간격을 조절하세요.
                    mainAxisSpacing: 4, // 세로 간격을 조절하세요.
                    crossAxisCount: 7),
                itemCount: 45,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      controller.selected(index);
                    },
                    child: Obx(
                      () => SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.orangeAccent),
                                        left: BorderSide(
                                            color: Colors.orangeAccent),
                                        right: BorderSide(
                                            color: Colors.orangeAccent)),
                                    color: controller.isSelected[index]
                                        ? Colors.black45
                                        : Colors.white),
                                height: 20),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.transparent),
                                        bottom: BorderSide(
                                            color: Colors.transparent),
                                        left: BorderSide(color: Colors.white),
                                        right: BorderSide(color: Colors.white)),
                                    color: controller.isSelected[index]
                                        ? Colors.black45
                                        : Colors.white),
                                child: Center(
                                  child: Text('${index + 1}'),
                                ),
                                height: 20),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.orangeAccent),
                                        left: BorderSide(
                                            color: Colors.orangeAccent),
                                        right: BorderSide(
                                            color: Colors.orangeAccent)),
                                    color: controller.isSelected[index]
                                        ? Colors.black45
                                        : Colors.white),
                                height: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  controller.saveList();
                },
                child: Text('저장하기')),
            TextButton(
                onPressed: () {
                  Get.toNamed(RouteNames.MYPAGE);

                },
                child: Text('확인하기')),
           Obx(() => Text('${controller.dblist}'))
          ],
        ),
      ),
    ));
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
                onTap: () {
                  controller.serial.value = 'option1';
                },
              ),
              ListTile(
                title: Text('Option 2'),
                onTap: () {
                  controller.serial.value = 'option2';
                },
              ),
              ListTile(
                title: Text('Option 3'),
                onTap: () {
                  controller.serial.value = 'option3';
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

  @override
  Future<bool> onBackPressed() async {
    // 뒤로 버튼을 눌렀을 때 수행할 작업
    // 예를 들어, Get.back()을 호출하여 이전 페이지로 이동
    Get.back();

    // 뒤로 버튼 처리를 직접 수행할 것이므로 true 반환
    return true;
  }
}
