import 'package:cloverlotto/model/selfnum.dart';
import 'package:get/get.dart';

import '../../db/dbhelper.dart';
import '../../model/loto.dart';

class SelfController extends GetxController {
  RxList<int> selectList = <int>[].obs;
  RxList<bool> isSelected = List.generate(45, (index) => false).obs;
  RxList dblist = [].obs;
  RxInt btnText = 0.obs;

  // 눌린 수 -> selectList 에 없으면 저장 있으면 제거

  // boolean값으로 저장
  void selected(int index) {
    //눌렸을때 리스트 가 5개 이하면 추가,삭제가능  6개면 삭제만
    if (selectList.length < 6) {
      isSelected[index] = !isSelected[index];
      if (isSelected[index]) {
        selectList.add(index + 1);
      } else {
        selectList.remove(index + 1);
      }
    } else {
      if (isSelected[index]) {
        isSelected[index] = !isSelected[index];
        selectList.remove(index + 1);
      }
    }
    //오름차순 정리
    selectList.sort();
  }

  void saveList() async {
    // await DBHelper().insertDataList(selectList);
    //await DBHelper().insertNumberListString(selectList);
    await DBHelper().insertDataList(selfNum(serial: btnText.value, num1: selectList[0],num2: selectList[1],num3: selectList[2],num4: selectList[3],num5: selectList[4],num6: selectList[5]));
    isSelected.assignAll(List.generate(45, (index) => false));
    selectList.clear();

  }

  void getList() async {
    List<List<int>> getlist = await DBHelper().queryAllLists();
    dblist.value = getlist;
  }

}
