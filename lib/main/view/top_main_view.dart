import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/main_controller.dart';

class TopMainView extends StatelessWidget {

  MainController controller;

  TopMainView({required this.controller});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      padding: EdgeInsets.only(top: 30.h),
      // color: Colors.black12,
      decoration: BoxDecoration(color: Colors.black12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() =>
              Text('')
          ),
          Obx(() => Text('${controller.lastSerial} 당첨 번호',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
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
    );
  }
}
