
import 'dart:ui';

import 'package:cloverlotto/model/qrpage.dart';
import 'package:cloverlotto/model/selfnum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../sqllite/db.dart';

class MyNumController extends GetxController with GetSingleTickerProviderStateMixin{
  // 저장된값
  RxList<selfNum> dblist = <selfNum>[].obs;
  RxList<selforigin> ballList = <selforigin>[].obs;
  late TabController tabController;

  RxList<List<selforigin>> QRballLists = <List<selforigin>>[].obs;
  RxList<QrInfo> qrtest =  <QrInfo>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getSelfList();
    getQrcodeList();
  }

  Future<void> getQrcodeList() async{
    List<QrInfo> qr = await DBHelper().getAllNumLists();
    print('sgsgsg+${qr.length}');

    for(QrInfo info in qr) {
      List<NumInfo> numInfoList = info.myNum ?? [];
      print('sgsgsg___${numInfoList.length}');

    }


    qrtest.value = qr;
  }


  // 아이템 한개 - >
  Future<List<List<selforigin>>> getTEST(int ser, List<NumInfo> mynums) async {
    List<int> winNums =  await DBHelper().queryByColumn2Value(ser);
    print('hbhb__ws${winNums.toString()}');

    List<List<selforigin>> nus = [];
    int sx = mynums.length;
    print('hbhb__my${sx}');
    // sx ( mynums 갯수만큼 반복)

    for (int i = 0 ; i < sx ; i++){
      List<selforigin>  n = [];
      List<int> m = [mynums[i].num1??0, mynums[i].num2??0, mynums[i].num3??0, mynums[i].num4??0, mynums[i].num5??0,mynums[i].num6??0];
      print('hbhb__mmm${m.toString()}');

      for(var i in m){
        if(winNums.contains(i)){
          n.add(selforigin(color:getColors(i),number: i));
        } else{
          n.add(selforigin(color: Colors.grey,number: i));
        }
        print('nnnnnnnnnn${n}');
      }
      nus.add(n);
    }

    return nus;
    // QRINFO 리스트 개수 , 공 리스트
  }





  // DB(selfNum)에 저장된 값 불러오기 ListView 테이블 한 행씩
  Future<void> getSelfList() async {
    // selfControll에서 저장한 리스트 여러개
    List<selfNum> dbList = await DBHelper().getselfList();
    dblist.value = dbList;
  }



  Future<List<selforigin>> getResults(selfNum se) async {
    List<selforigin>  n = [];
    // 해당 회차 당첨 번호 불러옴
    List<int> winNums =  await DBHelper().queryByColumn2Value(se.serial);
    print('hbsssswind'+winNums.toString());

    List<int> sl = [se.num1??0,se.num2??0,se.num3??0,se.num4??0,se.num5??0,se.num6??0];
    for(var i in sl){
      print('weg$i'+winNums.toString());
      if(winNums.contains(i)){
        n.add(selforigin(color:getColors(i),number: i));
      } else{
        n.add(selforigin(color: Colors.grey,number: i));
      }
    }
    print('hbhbs'''+n.toString());

    return n;
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
      return Colors.redAccent;
    }else if(31 <= num && num <= 40){
      return Colors.black;
    }else {
      return Colors.green;
    }
  }
}

