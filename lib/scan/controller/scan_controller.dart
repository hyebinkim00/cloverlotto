import 'dart:convert';

import 'package:cloverlotto/scan/view/scan_page.dart';
import 'package:cp949_codec/cp949_codec.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:intl/intl.dart';


class ScanController extends GetxController{


  RxList<int> selectList = <int>[].obs;
  RxList<bool> isSelected = List.generate(45, (index) => false).obs;
  RxString alertMessage = "".obs;

  List<Map<String, dynamic>> winNumList = <Map<String, dynamic>>[];

  // 눌린 수 -> selectList 에 없으면 저장 있으면 제거


  // boolean값으로 저장
  void selected(int index){

    isSelected[index] = !isSelected[index];

    if (isSelected[index]){
      selectList.add(index+1);
    }else{
      selectList.remove(index+1);
    }
  }


  Future<bool> getLastNo() async {
    // var url = Uri.parse('https://dhlottery.co.kr/gameResult.do?method=byWin&wiselog=C_A_1_1');
    // http.Response response = await http.get(url,headers:{ 'Content-Type': 'text/html; charset=EUC-KR', 'Accept-Charset': 'EUC-KR,*;q=0.8',}); /*charset=UTF-8*/
    final response = await http.get(Uri.parse('https://m.dhlottery.co.kr/qr.do?method=winQr&v=1095q061721243839q020304213138q143031414243q050609202731q1314214043451843447017'));
    final document = htmlParser.parse(cp949.decodeString(response.body));

    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return false;
    }

    //정보//
    // 로또 6/45
    // 회차번호(serial) 추첨일(date)
    // 당첨번호 (winner_list) (보너스는 plus) <!-- 번호별 컬러값: clr1: 1~10(노란) , clr2: 11~20(파란), clr3: 21~30(빨간), clr4: 31~40(검은), clr5: 41~45(초록) -->
    // 고른번호 (myNumList) ->

    final serial = document.querySelector('#container > div.contents > div.winner_number > h3 > span.key_clr1');
    final date = document.querySelector('#container > div.contents > div.winner_number > h3 > span.date');
    // 당첨 번호 ( className에 컬러값 , text에 번호)


    final winnerList = document.querySelectorAll('#container > div.contents > div.winner_number > div.bx_winner.winner > div.list > div');

    for(var item in winnerList){

      winNumList.add({'num':item.text,'color':getColor(item.className)});

      print('eeee_winnerList__color: ${item.className}number: ${item.text}');
    }

    final noticeWinner = document.querySelector("#container > div.contents > div.winner_number > div.bx_notice.winner");
    print('eeee_noticeWinner${noticeWinner!.text.trim()}');

    final myNumList = document.querySelectorAll("#container > div.contents > div.list_my_number > div > table > tbody > tr");
    for(var mynumTable in myNumList){
      final th = mynumTable.querySelector('th');
      final td = mynumTable.querySelector('td');
      print('eee_myNumList_th'+th!.text.trim());
      print('eee_myNumList_td'+td!.text);
      final tb = mynumTable.querySelectorAll('span');
      for(var myNum in tb){
        print('eee_myNumList_span___'+myNum.className+'num__'+myNum.text);
      }

    }
    return true;
  }





  Color getColor(String num){
    if(num.contains('clr1')){
     return Colors.yellowAccent;
    } else if (num.contains('clr2')){
      return Colors.blueAccent;
    } else if (num.contains('clr3')){
      return Colors.redAccent;
    } else if (num.contains('clr4')){
      return Colors.black;
    }else if(num.contains('clr5')){
      return Colors.greenAccent;
    }else{
      return Colors.transparent;
    }
  }

}
