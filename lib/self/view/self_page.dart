import 'package:cloverlotto/db/dbhelper.dart';
import 'package:cloverlotto/ui/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../config/route_names.dart';
import '../../main/controller/main_controller.dart';
import '../controller/self_controller.dart';

class SelfPage extends GetView<SelfController> {
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Scaffold(
      body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                // 회차 선택 버튼 클릭 시 "SelectAlert"
                Obx(() {
                  if (controller.btnText.value == 0) {
                    controller.btnText.value = mainController.lastSerial.value;
                    return Text('${controller.btnText}');
                  } else {
                    return Text('${controller.btnText}');
                  }
                }),
                TextButton(
                  child: Text('회차 선택'),
                  onPressed: () {DialogUtils.selectSerial(context,controller);},
                ),

                // MainController에서 최신 회차 저장 , 회차 별 당첨 번호 저장
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.5),
                    itemCount: 45,
                    itemBuilder: (context, index) {
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
                                            left:
                                                BorderSide(color: Colors.white),
                                            right: BorderSide(
                                                color: Colors.white)),
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
                SizedBox(height: 30),
                Obx(
                  () => Text(
                    '선택한 번호: ${controller.selectList.isEmpty ? "" : controller.selectList.join(', ')}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // 보통 5000 원 단위로 사니까 한번에 해야 될지 1000원 단위로 할지
                TextButton(
                    onPressed: () {
                      // select 초기화 , 선택된거 하얀색
                      controller.saveList();
                    },
                    child: Text('저장하기')),
                TextButton(
                    onPressed: () {
                      Get.toNamed(RouteNames.MYPAGE);
                    },
                    child: Text('확인하기')),
              ],
            ),
          )),
    );
  }
}
