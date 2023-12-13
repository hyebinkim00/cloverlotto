import 'package:cloverlotto/config/route_names.dart';
import 'package:cloverlotto/main/controller/main_controller.dart';
import 'package:cloverlotto/qrscan/view/qrscan_page.dart';
import 'package:cloverlotto/random/view/random_page.dart';
import 'package:cloverlotto/self/view/self_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


// Container(
// width: 300.w,
// height: 400.h,
// color: Colors.red,
// )

class MainPage extends GetView<MainController>{

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  final List<String> cardText = ['MBTI로 보는 오늘의 번호','오늘의 운세로 보는 번호','번호 추첨기','랜덤뽑기'];

  // Main -> 당첨번호 확인 (QR / 직접입력) , 번호추천 (랜덤  , MBTI , 운세) , 기록 (당첨확인 목록, 번호추천 목록)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _key,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black12,
        // title: Text('LottoApp'),
        // centerTitle: true,
        leading: IconButton(onPressed: () { }, icon: Icon(Icons.camera_alt_outlined),
        ),
        actions:  [
          IconButton(
              onPressed:() => _key.currentState!.openDrawer(),
              icon: Icon(Icons.menu))],
      ),
      drawer: Drawer(// 오른쪽은 endDrawer & openEndDrawer
        child:  ListView(
          children: [
            UserAccountsDrawerHeader(
              // currentAccountPicture: CircleAvatar(
              // ),
              // otherAccountsPictures: [
              //   CircleAvatar(
              //   ),
              // ],
              accountName: Text('기록보기'),
              accountEmail: Text('abc12356@naver.com'),
              onDetailsPressed: () {},
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('당첨 기록'),
              onTap: () {
                print('Alarm Start');},
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_cart_rounded),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('생성번호 목록'),
              onTap: () {},
              trailing: Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: Icon(Icons.mark_as_unread_sharp),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('분석'),
              onTap: () {},
              trailing: Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: Icon(Icons.restore_from_trash),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('휴지통'),
              onTap: () {},
              trailing: Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('개인정보처리방침'),
              onTap: () {},
              trailing: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          height: Get.height,//double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 300.h,
                  padding: EdgeInsets.only(top: 30.h),
                  // color: Colors.black12,
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 오늘 날짜
                      Text(controller.getDate()),
                      // 최신회차 당첨 번호
                      Obx(() => Text('${controller.kk} 당첨 번호',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(8, (index) {
                          String numbers = controller.ll[index].toString();
                          print(numbers);
                          if(index==6){
                            numbers='+';
                          }
                          //     1번부터 10번까지는 노란색입니다.
                          // 11번 부터 20번까지는 파란색입니다.
                          // 21번부터 30번까지는 빨간색입니다.
                          // 31번부터 40번까지는 검은색입니다.
                          // 41번부터 45번까지는 초록색입니다.
                          Color back = Colors.transparent;

                          if (1<=controller.ll[index]&&controller.ll[index]<=10){
                            back= Colors.yellow;
                          }else if(11<=controller.ll[index]&&controller.ll[index]<=20){
                            back= Colors.blue;
                          }else if(21<=controller.ll[index]&&controller.ll[index]<=30){
                            back= Colors.red;
                          }else if (31<=controller.ll[index]&&controller.ll[index]<=40){
                            back = Colors.black;
                          }else if(41<=controller.ll[index]&&controller.ll[index]<=45){
                            back= Colors.green;
                          }

                          // switch(_controller.ll[index]~/10){
                          //   case 0:
                          //     back= Colors.yellow;
                          //     break;
                          //   case 1:
                          //     back= Colors.blue;
                          //     break;
                          //   case 2:
                          //     back= Colors.red;
                          //     break;
                          //   case 3:
                          //     back= Colors.black;
                          //     break;
                          //   case 4:
                          //     back= Colors.green;
                          //     break;
                          // }

                          return Expanded(
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              margin: EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: back,
                              ),
                              child: Center(
                                  child:
                                  Text(numbers,
                                    style: TextStyle(
                                      color: Colors.white, // 텍스트 색상 설정
                                      fontSize: 24.0, // 텍스트 크기 설정
                                    ),)),
                            ),
                          );
                        }),
                      )),
                      Row(
                          children: [
                            SizedBox(width: 16.0), // 왼쪽 간격 추가
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(onPressed: (){
                               // Get.offAndToNamed(RouteNames.SELF);
                                Get.toNamed(RouteNames.SELF);
                              },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.confirmation_number_outlined),
                                      Text('번호 직접 입력')
                                    ],
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Get.toNamed(RouteNames.QRSACN);
                                    },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.camera_alt_outlined),
                                      Text('QR코드 스캔')
                                    ],
                                  )),
                            ),
                            SizedBox(width: 16.0), // 왼쪽 간격 추가

                          ]
                      )
                    ],
                  ),
                ),
                // TopMainView(controller: controller,),
                SizedBox(
                  width: 200,
                  height: 50,
                ),
                // MBTI , 직접보기
                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 10,bottom: 10),
                        child: Text('번호를 추천해드릴께요!',style: TextStyle(fontSize: 15),)),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                      shrinkWrap: true, // You won't see infinite size error
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){
                            if (index==3){
                              Get.to(()=> RandomPage());
                            }
                            print('HBS::: $index');
                          },
                          child: myMenu(index),
                        );
                      },
                      itemCount: cardText.length,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget myMenu(int index) {
    return Container(
      child: Card(
        color: Colors.lightGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child: Center(
          child: Text('${cardText[index]}',style: TextStyle(color:Colors.white)),
        ),),
      // width: 100.0, // 네모박스의 가로 크기
      // height: 100.0, // 네모박스의 세로 크기
      // color: Colors.white70, // 배경색
      // margin: EdgeInsets.all(8.0), // 네모박스 간의 간격 설정
    );
  }

}