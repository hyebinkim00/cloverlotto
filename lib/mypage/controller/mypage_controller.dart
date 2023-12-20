
import 'dart:ui';

import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/model/selfnum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../sqllite/db.dart';

class MyPageController extends GetxController{
  // 저장된값
  RxList<selfNum> list = <selfNum>[].obs;

  RxList<numInfo> ballList = <numInfo>[].obs;
  List<Map<String, dynamic>> winNumList = <Map<String, dynamic>>[];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSelfList();
  }


  // DB(selfNum)에 저장된 값 불러오기 ListView 테이블 한 행씩
  Future<void> getSelfList() async {

    // selfControll에서 저장한 리스트 여러개
    List<selfNum> dbList = await DBHelper().getselfList();
    list.value = dbList;
    for(int i =0; i<dbList.length; i++){
      List<int> list =[ dbList[i].num1??0,dbList[i].num2??0,dbList[i].num3??0,dbList[i].num4??0,dbList[i].num5??0];
      getResult(list, dbList[i].serial);
    }

  }

  // List 한줄씩 비교 --> 5개
  Future<List<numInfo>> getResult(List<int> list, int? serial) async{
    List<numInfo>  n = [];
    List<int> winNums =  await DBHelper().queryByColumn2Value(serial);
    print('hbs+__$winNums.toString()');
    for(var i in list){
      if(winNums.contains(i)){
        n.add(numInfo(color:getColors(i),number: i));
      } else{
        n.add(numInfo(color: Colors.transparent,number: i));
      }

    }
    ballList.value = n;
    return [];
  }


  // selfList ( 회차 + 번호 6개 )
  // lotoList ( 회차 에 대한 당첨번호 )


  Color getColors(int num){
    //     1번부터 10번까지는 노란색입니다.
    // 11번 부터 20번까지는 파란색입니다.
    // 21번부터 30번까지는 빨간색입니다.
    // 31번부터 40번까지는 검은색입니다.
    // 41번부터 45번까지는 초록색입니다.
    if (1 <= num && num <= 10) {
      return Colors.yellowAccent;
    }else if(11 <= num && num <= 20){
      return Colors.blueAccent;
  }else if(21 <= num && num <= 30){
      return Colors.blueAccent;
    }else if(31 <= num && num <= 40){
      return Colors.blueAccent;
    }else {
      return Colors.blueAccent;
    }
  }
}

