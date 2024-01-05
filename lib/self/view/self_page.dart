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
            children: [
              //회차 선택
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.all(20),
                color: Colors.deepOrangeAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '제 ${Get.arguments['lastSerial']}회',
                      style: const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // OutlinedButton(
                    //     onPressed: () {
                    //       showOptionDialog(context);
                    //     },
                    //     child: Text('회차변경'))
                  ],
                ),
              ),
              // Obx(() => TextButton(
              //       onPressed: () {
              //         showOptionDialog(context);
              //       },
              //       style: ButtonStyle(
              //           backgroundColor:
              //               MaterialStateProperty.all<Color>(Colors.orange),
              //           foregroundColor:
              //               MaterialStateProperty.all<Color>(Colors.white)),
              //       // MainController에서 최신 회차를 가져옴
              //       // 초기 값을 '회차 선택'으로 바꿔야하나 고민
              //       child: Text('제 ${Get.arguments['lastSerial']}회'),
              //     )),
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
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white)),
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
                style:  ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.deepOrangeAccent,
                      foregroundColor: Colors.white,
                ), onPressed: () {
                    controller.saveList();
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
