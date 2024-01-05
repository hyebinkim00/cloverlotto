import 'package:cloverlotto/model/selfnum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../model/loto.dart';
import '../../sqllite/db.dart';

class SelfController extends GetxController {
  RxList<int> selectList = <int>[].obs;
  RxList<bool> isSelected = List.generate(45, (index) => false).obs;
  // RxInt serial = 0.obs;

  @override
  void onInit() {
    // var last = Get.arguments['lastSerial'];
    // serial.value = last;
    super.onInit();
  }
  // 눌린 수 -> selectList 에 없으면 저장 있으면 제거

  // boolean값으로 저장

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




  // 선택한 번호 6개 저장하기
  void saveList() async {
    if (selectList.length!=6){
      Fluttertoast.showToast(msg: '숫자 6개를 입력하세요!');
    } else{
    await DBHelper().insertDataList(selfNum(serial: 1099,num1: selectList[0],num2: selectList[1],num3: selectList[2],num4: selectList[3],num5: selectList[4],num6: selectList[5]));
    isSelected.assignAll(List.generate(45, (index) => false));
    selectList.clear();
    }
    // selectDb();
  }

  // 저장된 번호 리스트
  void getList() async {
    List<selfNum> allLists = await DBHelper().getselfList();

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

}