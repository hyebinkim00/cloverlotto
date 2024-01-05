import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/mypage/controller/mypage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/selfnum.dart';

class MyPage extends GetView<MyPageController> {
  List<numInfo>? numBox = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nested ListView Example'),
        ),
        body: Obx(()=>
            ListView.builder(
              itemCount: controller.dblist.length, // 예제로 5개의 항목을 만듭니다.
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100, // 각 항목의 높이를 설정합니다.
                  child: FutureBuilder(
                      future: controller.getResults(controller.dblist[index]),
                      builder: (context,snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // return CircularProgressIndicator();// 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
                          return Container(color: Colors.transparent,);
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return Text('No data available'); // 데이터가 없는 경우에 대한 처리를 추가합니다.
                        }
                        else if (snapshot.data != null && snapshot.hasData) {
                          controller.ballList.value = snapshot.data!;
                        }
                        return Container(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, // 가로 방향으로 스크롤합니다.
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context , int indexs){
                              return Container(
                                width: 50.0,
                                height: 50.0,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: snapshot.data![indexs].color,
                                ),
                                child: Center(
                                    child: Text(
                                      '${snapshot.data![indexs].number}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // 텍스트 색상 설정
                                        fontSize: 24.0, // 텍스트 크기 설정
                                      ),
                                    )),
                              );
                            },
                          ),
                        );
                      }),
                );
              },
            )),
      ),
    );
  }
    //     body: SafeArea(
    //   child: Obx(() =>
    //       // 리스트 정보
    //       ListView.builder(
    //           itemCount: controller.dblist.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return Center(
    //               child: Column(children: [
    //                 Text(('${controller.dblist[index].serial}')), // 회차
    //                 FutureBuilder(
    //                     future:
    //                         controller.getResults(controller.dblist[index]),
    //                     builder: (context, snapshot) {
    //                       if (snapshot.data != null && snapshot.hasData) {
    //                         numBox = snapshot.data;
    //                         print('dfDDDD${numBox!.length}');
    //                       }
    //                       return Container(
    //                           child: ListView.builder(scrollDirection: Axis.horizontal,
    //                         itemCount: numBox!.length,
    //                           itemBuilder:
    //                               (BuildContext context, int indexs) {
    //                         return Expanded(
    //                           child: Container(
    //                             width: 50.0,
    //                             height: 50.0,
    //                             margin: EdgeInsets.only(left: 5, right: 5),
    //                             decoration: BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               color: numBox![indexs].color,
    //                             ),
    //                             child: Center(
    //                                 child: Text(
    //                               '${numBox![indexs].number}',
    //                               style: TextStyle(
    //                                 color: Colors.black,
    //                                 // 텍스트 색상 설정
    //                                 fontSize: 24.0, // 텍스트 크기 설정
    //                               ),
    //                             )),
    //                           ),
    //                         );
    //                       }));
    //                     })
    //               ]),
    //             );
    //           })),
    // ));
  }

