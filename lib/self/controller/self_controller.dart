import 'package:get/get.dart';

import '../../sqllite/db.dart';

class SelfController extends GetxController {
  RxList<int> selectList = <int>[].obs;
  RxList<bool> isSelected = List.generate(45, (index) => false).obs;
  RxString serial = '회차 선택'.obs;
  RxString dbs = 'null'.obs;
  List<int> dbItem = [];
  RxBool db = false.obs;
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
    print('SELLE'+selectList.toString());
  }

  
  void saveList() async {
    // await DBHelper().insertDataList(selectList);
    await DBHelper().insertNumberListString(selectList);
    db.value = true;
    getList();
    // selectDb();
  }

  void getList() async {
    List<List<int>> allLists = await DBHelper().queryAllLists();
    dblist.value = allLists;
  }

  // DB Helper
  Future<List<List<int>>> selectDb() async {
    List<List<int>> result = <List<int>>[];

    Future<List<Map<String, dynamic>>> db = DBHelper().selectData('selfNum');
    List<Map<String, dynamic>> data = await db;
    print('HB_SELCETD__'+'${data[0]['value1']}');
    print('HB_SELCETD__'+'${data[0]['value2']}');
    print('HB_SELCETD__'+'${data[0]['value3']}');
    print('HB_SELCETD__'+'${data[0]['value4']}');
    print('HB_SELCETD__'+'${data[0]['value5']}');


    for (Map<String, dynamic> row in data) {
      print('HB_SELCET__'+'${row['value1']}');
      print('HB_SELCET__'+'${row['value2']}');
      print('HB_SELCET__'+'${row['value3']}');
      print('HB_SELCET__'+'${row['value4']}');
      print('HB_SELCET__'+'${row['value5']}');
    }
    result.add(dbItem);
    return result;
  }

  void selectLatest() async {
    Future<List<Map<String, dynamic>>> db = DBHelper().selectData('latest');
    List<Map<String, dynamic>> data = await db;
    print('hhhhh''${data[0]['serial']}');
  }
}
