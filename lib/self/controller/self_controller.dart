import 'package:get/get.dart';

class SelfController extends GetxController {
  RxList<int> selectList = <int>[].obs;
  RxList<bool> isSelected = List.generate(45, (index) => false).obs;

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
}
