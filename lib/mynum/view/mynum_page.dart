import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/mynum/controller/mynum_controller.dart';
import 'package:cloverlotto/mypage/controller/mypage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/selfnum.dart';

class MyNumPage extends GetView<MyNumController> {

  // 앱바에서 뒤로 버튼
  // 탭바로 직접입력 , QR스캔 분리

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButtonIcon(),
          title: Text('저장 목록'),
        ),
        body:
        Column(
          children: [
            // 회차 선택
            TabBar(tabs: [Tab(text: '직접입력'),Tab(text:'QR스캔')],
            controller: controller.tabController,
            indicatorColor: Colors.deepOrangeAccent,
            padding: EdgeInsets.all(10),
            labelColor: Colors.black,
            // indicator: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(
            //     0xffffa228)),
            unselectedLabelColor: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_left)),
              Text('1102회', style: TextStyle(fontSize: 20),),
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_right))
            ],),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                  children: tabList()),
            )

          ],
        ),
      ),
    );
  }


  List<Widget> tabList (){
    return [
      Center(
        child:  Container(
          child: Obx(()=>
              ListView.builder(
                itemCount: controller.dblist.length, // 예제로 5개의 항목을 만듭니다.
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1.0)
                    ),
                    height: 150, // 각 항목의 높이를 설정합니다.
                    child: Column(
                      children: [
                        Text('${controller.dblist[index].serial}'),
                        FutureBuilder(
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
                                width: 200.0,
                                height: 50.0,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal, // 가로 방향으로 스크롤합니다.
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context , int indexs){
                                    return Container(
                                      width: 30.0,
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
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
      // QR 은 한 회차에 여려개 번호 리스트
      Center(
        child:  Container(
          child: Obx(()=>
        // DB 에 저장되어 있는 QR정보들 리스트
              ListView.builder(
                itemCount: controller.qrtest.length, // 예제로 5개의 항목을 만듭니다.
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1.0)
                    ),
                    height: 150, // 각 항목의 높이를 설정합니다.
                    // 정보 한개씩 박스 안에 표시
                    child: Column(
                      children: [
                        Text('${controller.qrtest[index].myNum??[]}'),
                        FutureBuilder(
                          // controller.qrtest 안에 serial , List<QRInfo> 리스트 (DB 리스트)
                            future: controller.getTEST(1102,controller.qrtest[index].myNum??[]),
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
                                print('SSSSBBB${snapshot.data}');
                                //
                                controller.QRballLists.value = snapshot.data!;
                              }
                              return Expanded(
                                // 세로 리스트 ( NumInfo 갯수)
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return  Container(
                                      width: 200.0,
                                      height: 50.0,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal, // 가로 방향으로 스크롤합니다.
                                        itemCount: snapshot.data![index].length,
                                        itemBuilder: (BuildContext context , int indexs){
                                          return Container(
                                            width: 30.0,
                                            height: 50.0,
                                            margin: EdgeInsets.only(left: 5, right: 5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: snapshot.data![index][indexs].color,
                                            ),
                                            child: Center(
                                                child: Text(
                                                  '${snapshot.data![index][indexs].number}',
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
                                  },
                                ),
                              );
                            }),
                      ],
                    ),
                  );
                },
              )),
        ),
      )
    ];
  }





  }

