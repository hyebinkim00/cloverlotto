class selfNum {
  int? serial;
  int? num1;
  int? num2;
  int? num3;
  int? num4;
  int? num5;
  int? num6;

  selfNum({this.serial, this.num1, this.num2, this.num3, this.num4, this.num5, this.num6});

  //DB 저장

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'num1': num1,
      'num2': num2,
      'num3': num3,
      'num4': num4,
      'num5': num5,
      'num6': num6
    };
  }

  selfNum.fromMap(Map<dynamic, dynamic> map) {
    serial = map?['serial'];
    num1 = map?['num1'];
    num2 = map?['num2'];
    num3 = map?['num3'];
    num4 = map?['num4'];
    num5 = map?['num5'];
    num6 = map?['num6'];
  }

  @override
  String toString() {
    return 'selfNum{serial: $serial, num1: $num1, num2: $num2, num3: $num3, num4: $num4, num5: $num5, num6: $num6}';
  }
}
