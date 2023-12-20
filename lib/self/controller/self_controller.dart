import 'package:cloverlotto/model/selfnum.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../model/loto.dart';
import '../../sqllite/db.dart';

class SelfController extends GetxController {
  RxList<int> selectList = <int>[].obs;
  RxList<bool> isSelected = List
      .generate(45, (index) => false)
      .obs;
  RxString serial = '회차 선택'.obs;
  RxString dbs = 'null'.obs;
  List<int> dbItem = [];
  RxList dblist = [].obs;


  // 눌린 수 -> selectList 에 없으면 저장 있으면 제거

  // boolean값으로 저장
  void selected(int index) {
    isSelected[index] = !isSelected[index];

    if (isSelected[index]) {
      selectList.add(index + 1);
    } else {
      selectList.remove(index + 1);
    }
    print('SELLE' + selectList[0].toString());
  }


  // 선택한 번호 6개 저장하기
  void saveList() async {
    await DBHelper().insertDataList(selfNum(serial: 1098,num1: selectList[0],num2: selectList[1],num3: selectList[2],num4: selectList[3],num5: selectList[4],num6: selectList[5]));
    // selectDb();
    getList();
  }

  // 저장된 번호 리스트
  void getList() async {
    List<selfNum> allLists = await DBHelper().getselfList();
    for (var item in allLists){
      dblist.add(item);
    }
  }



  // 당첨 번호 비교하는 로직 필요
  void selectdrwNo() async {
    List<int> db = await DBHelper().queryByColumn2Value(1098);
    print('HHHHHHD_' + '${db.length}');
    // 결과 출력 또는 원하는 작업 수행
    // for (Map<String, dynamic> row in db) {
    //   print(
    //       'ID: ${row['drwNo']}, Column1: ${row['drwNo']}, Column2: ${row['drwNo']}');
    // }
  }


  void winCheck(Loto loto) {
    // 1. 고른 번호 회차, 저장된 번호 회차
  }





}