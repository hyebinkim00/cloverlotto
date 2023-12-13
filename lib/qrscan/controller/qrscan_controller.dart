import 'dart:convert';

import 'package:cloverlotto/model/qrInfo.dart';
import 'package:cloverlotto/ui/dialog_utils.dart';
import 'package:cp949_codec/cp949_codec.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrscanController extends GetxController{
  RxString totalResponse = "".obs;
  late List<NumData> winnerLists=[];
  late List<NumData> myNumLists=[];
  late QrInfo qtinfo;
  QRViewController? qrViewController;

  // https://m.dhlottery.co.kr/qr.do?method=winQr&v=1095q061721243839q020304213138q143031414243q050609202731q1314214043451843447017

  void barcodeResult(String barcodeData) async {
    qrViewController!.resumeCamera();
    print('hbhbhb'+barcodeData);
    final response = await http.get(Uri.parse(
        'https://m.dhlottery.co.kr/qr.do?method=winQr&' + barcodeData));
    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return;
    }
    // 응답이 euc-kr 로 와서 한글이 깨짐 -> cp949 디코딩
    final document = htmlParser.parse(cp949.decodeString(response.body));

    //정보//
    // 로또 6/45
    // 회차번호(serial) 추첨일(date)
    // 당첨번호 (winner_list) (보너스는 plus) <!-- 번호별 컬러값: clr1: 1~10(노란) , clr2: 11~20(파란), clr3: 21~30(빨간), clr4: 31~40(검은), clr5: 41~45(초록) -->
    // 고른번호 (myNumList) -> th : 행 번호 (A~) , td :결과 ,

    final serial = document.querySelector(
        '#container > div.contents > div.winner_number > h3 > span.key_clr1');
    print('hbhbSer'+serial!.text);
    final date = document.querySelector(
        '#container > div.contents > div.winner_number > h3 > span.date');
    // 당첨 번호 ( className에 컬러값 , text에 번호)

    final winnerList = document.querySelectorAll(
        '#container > div.contents > div.winner_number > div.bx_winner.winner > div.list > div');

    for (var item in winnerList) {
      winnerLists.add(NumData(number: item.text,color: getColor(item.className)));
      print('eeee_winnerList__color: ${item.className}number: ${item.text}');
    }

    final noticeWinner = document.querySelector(
        "#container > div.contents > div.winner_number > div.bx_notice.winner");
    print('eeee_noticeWinner${noticeWinner!.text.trim()}');

    final myNumList = document.querySelectorAll(
        "#container > div.contents > div.list_my_number > div > table > tbody > tr");
    for (var mynumTable in myNumList) {
      final th = mynumTable.querySelector('th');
      final td = mynumTable.querySelector('td');
      print('eee_myNumList_th' + th!.text.trim());
      print('eee_myNumList_td' + td!.text);
      final tb = mynumTable.querySelectorAll('span');
      for (var myNum in tb) {
        myNumLists.add(NumData(number:myNum.text,color:getColor(myNum.className)));
        print('eee_myNumList_span___' + myNum.className + 'num__' + myNum.text);
      }
    }

    qtinfo =QrInfo(serial: serial!.text,date: date!.text,winnerList: winnerLists,notice: noticeWinner!.text,myNumList: myNumLists);
    DialogUtils.qrResult(qtinfo);
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

  void dialog(){
    Get.dialog(AlertDialog(
      title: Text('로또 결과'),
      content: Text('몇회 + 번호'),
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            onPressed: () {
              Get.back(); //창 닫기
            },
            child: Text("저장하기"),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              qrViewController!.resumeCamera();
              Get.back(); //창 닫기
            },
            child: Text("다시 스캔하기"),
          ),
        ),
      ],
    ));

  }

}