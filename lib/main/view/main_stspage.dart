import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cloverlotto/main.dart';
import 'package:cloverlotto/main/controller/main_controller.dart';
import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/random/view/random_page.dart';
import 'package:cloverlotto/self/controller/self_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:random_text_reveal/random_text_reveal.dart';

import '../../config/route_names.dart';

// Container(
// width: 300.w,
// height: 400.h,
// color: Colors.red,
// )


class MainPage2 extends StatelessWidget{

  // MainController mainController = Get.put(MainController());
  String  gg = '[4,6,i8,9,1,4]';

  final List<String> cardText = [
    'MBTI로 보는 오늘의 번호',
    '오늘의 운세로 보는 번호',
    '번호 추첨기',
    '랜덤뽑기'
  ];

  String getToday() {
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');

    return dateFormat.format(dateTime);
  }

  // Main -> 당첨번호 확인 (QR / 직접입력) , 번호추천 (랜덤  , MBTI , 운세) , 기록 (당첨확인 목록, 번호추천 목록)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
               Get.toNamed(RouteNames.SPINNING);

          // MainController mainController = Get.find<MainController>();
          // mainController.sqte();
        },
      ),
      body: GetBuilder<MainController>(
          init: MainController(),
          builder: (controller) {
            controller.getLastNo();
            return Container(
              height: Get.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      padding: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(color: Colors.amberAccent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => Text(
                              '${controller.kk}회 당첨 번호',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(getToday()),
                          Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(8, (index) {
                                  String numbers =
                                      controller.ll[index].toString();
                                  if (index == 6) {
                                    numbers = '+';
                                  }
                                  //     1번부터 10번까지는 노란색입니다.
                                  // 11번 부터 20번까지는 파란색입니다.
                                  // 21번부터 30번까지는 빨간색입니다.
                                  // 31번부터 40번까지는 검은색입니다.
                                  // 41번부터 45번까지는 초록색입니다.
                                  Color back = Colors.lightGreen;
                                  if (controller.ll[index] ~/ 10 == 1) {
                                    back = Colors.red;
                                  }
                                  return Expanded(
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: back,
                                      ),
                                      child: Center(
                                          child: Text(
                                        numbers,
                                        style: TextStyle(
                                          color: Colors.white, // 텍스트 색상 설정
                                          fontSize: 24.0, // 텍스트 크기 설정
                                        ),
                                      )),
                                    ),
                                  );
                                }),
                              )),
                          Row(children: [
                            SizedBox(width: 16.0), // 왼쪽 간격 추가
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(RouteNames.SELF, arguments: {
                                      'lastSerial': controller.lastSerial
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.confirmation_number_outlined),
                                      Text('번호 직접 입력')
                                    ],
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(RouteNames.MYPAGE);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => RandomPage()),
                                    // );

                                    print('HBSHB');
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.camera_alt_outlined),
                                      Text('QR코드 스캔')
                                    ],
                                  )),
                            ),
                            SizedBox(width: 16.0), // 왼쪽 간격 추가
                          ])
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 200,
                      height: 50,
                    ),

                    FadeIn(
                      animate: true,
                      delay: const Duration(milliseconds: 2000),
                      onFinish: (direction) => print('$direction'),
                      child: const Square(),
                    ),
                    FlipInX(
                      animate: true,
                      delay: const Duration(milliseconds: 2000),
                      onFinish: (direction) => print('$direction'),
                      child: const Square(),
                    ),
                    Obx(() =>
                        RandomTextReveal(
                      key: controller.globalKey,
                      initialText: '12345678',
                      shouldPlayOnStart: false,
                      text: controller.rxString.value ,
                      duration: const Duration(seconds: 3),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8,
                      ),
                      randomString: '123455678910',
                      onFinished: () {

                      },
                      curve: Curves.easeIn,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    )
                    // MBTI , 직접보기
                    //
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //         padding: EdgeInsets.only(left: 10,bottom: 10),
                    //         child: Text('번호를 추천해드릴께요!',style: TextStyle(fontSize: 15),)),
                    //     GridView.builder(
                    //       physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    //       shrinkWrap: true, // You won't see infinite size error
                    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    //       itemBuilder: (BuildContext context, int index){
                    //         return GestureDetector(
                    //           onTap: (){
                    //             if (index==0){
                    //               controller.qrTest();
                    //              // Get.toNamed(RouteNames.RANDOM);
                    //             } else if(index == 1){
                    //               Get.toNamed(RouteNames.MYPAGE);
                    //             }else if(index == 2){
                    //               Get.toNamed(RouteNames.RANDOM);
                    //             }else if(index == 3){
                    //               Get.toNamed(RouteNames.SPINNING);
                    //
                    //             }
                    //             print('HBS::: $index');
                    //           },
                    //           child: myMenu(index),
                    //         );
                    //       },
                    //       itemCount: cardText.length,),
                    //   ],
                    // )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget myMenu(int index) {
    return Container(
      child: Card(
        color: Colors.lightGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child: Center(
          child:
              Text('${cardText[index]}', style: TextStyle(color: Colors.white)),
        ),
      ),
      // width: 100.0, // 네모박스의 가로 크기
      // height: 100.0, // 네모박스의 세로 크기
      // color: Colors.white70, // 배경색
      // margin: EdgeInsets.all(8.0), // 네모박스 간의 간격 설정
    );
  }
}

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        )
    );
  }
}
