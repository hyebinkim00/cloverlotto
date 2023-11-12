import 'package:cloverlotto/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


// Container(
// width: 300.w,
// height: 400.h,
// color: Colors.red,
// )

class MainPage extends GetView<MainController>{

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  List<int> test =[18,30,42,42,3,44,8,9];
  final MainController _controller = Get.put(MainController());

  final List<String> cardText = ['MBTI로 보는 오늘의 번호','오늘의 운세로 보는 번호','번호 추첨기','랜덤뽑기'];

  String getToday(){
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');

    return dateFormat.format(dateTime) ;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _key,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
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
        top: false,
        child: Container(
          height: double.infinity,
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
                      Obx(() =>
                          Text(_controller.numbers.value?.returnValue??'nodata')),
                      Text('---- 회 당첨 번호',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      Text(getToday()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(8, (index) {
                          String numbers = test[index].toString();
                          if(index==6){numbers='+';}
                          //     1번부터 10번까지는 노란색입니다.
                          // 11번 부터 20번까지는 파란색입니다.
                          // 21번부터 30번까지는 빨간색입니다.
                          // 31번부터 40번까지는 검은색입니다.
                          // 41번부터 45번까지는 초록색입니다.
                          Color back = Colors.lightGreen;
                          if(test[index]~/10==1){
                            back= Colors.red;
                          }
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
                      ),
                      Row(
                          children: [
                            SizedBox(width: 16.0), // 왼쪽 간격 추가
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(onPressed: (){},
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
                                    print('HBSHB');
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
                      itemBuilder: (BuildContext context, int idex){
                        return GestureDetector(
                          onTap: (){

                            print('HBS::: $idex');
                          },
                          child: myMenu(idex),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child: Center(
          child: Text(cardText[index]),
        ),),
      // width: 100.0, // 네모박스의 가로 크기
      // height: 100.0, // 네모박스의 세로 크기
      // color: Colors.white70, // 배경색
      // margin: EdgeInsets.all(8.0), // 네모박스 간의 간격 설정
    );
  }

}