import 'package:cloverlotto/db/dbhelper.dart';
import 'package:cloverlotto/model/qrInfo.dart';
import 'package:cloverlotto/qrscan/controller/qrscan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../model/loto.dart';
import '../self/controller/self_controller.dart';

class DialogUtils {
  QRViewController? qrViewController;

  static void qrResult(qrinfo) {
    QrInfo info = qrinfo;
    Get.dialog(AlertDialog(
      title: Text('스캔 결과'),
      content: Container(
        child: Column(
          children: [
            Text('${info.serial}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(info.winnerList!.length, (index) {
                return Expanded(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: info.winnerList![index].color,
                    ),
                    child: Center(
                        child: Text(
                      '${info.winnerList![index].number}',
                      style: TextStyle(
                        color: Colors.white, // 텍스트 색상 설정
                        fontSize: 24.0, // 텍스트 크기 설정
                      ),
                    )),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
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
              Get.back(); //창 닫기
            },
            child: Text("다시 스캔하기"),
          ),
        ),
      ],
    ));
  }

  static selectSerial(BuildContext context, SelfController controller) async {
    List<Loto> lotos = await DBHelper().getLoto();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(textAlign: TextAlign.center, '회차 선택'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                itemCount: lotos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text('${lotos[index].drwNo}' + '회 ' +
                          '( ${lotos[index].drwNoDate} 추첨 )'),
                  onTap: (){
                        controller.btnText.value =lotos[index].drwNo!;
                    Navigator.of(context).pop();
                  },);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
            //Column(
            //                 children: List.generate(lotos.length, (int index) {
            //                   return Text('${lotos[index].drwNo}'+'회' + '${lotos[index].drwNoDate}');
            //                 }),
            //               )
          );
        });
  }
}
