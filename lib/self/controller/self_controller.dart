import 'package:get/get.dart';

class SelfController extends GetxController{


  RxList<int> selectList = <int>[].obs;
  RxList<bool> isSelected = List.generate(45, (index) => false).obs;

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

}
