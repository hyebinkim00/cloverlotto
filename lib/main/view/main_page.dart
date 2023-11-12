import 'package:cloverlotto/main/controller/main_controller.dart';
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

  List<int> test =[18,30,42,42,3,44,8,9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(color: Colors.amberAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('---- 회 당첨 번호',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  Text('2023.11.04'),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}