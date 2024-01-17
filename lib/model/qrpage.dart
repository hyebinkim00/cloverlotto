import 'dart:convert';

import 'package:flutter/material.dart';

class QrInfo {
  int? serial;
  List<NumInfo>? myNum;

  QrInfo({this.serial, this.myNum});

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'myNum':  jsonEncode(myNum!.map((numInfo) => numInfo.toMap()).toList()),
    };
  }

  factory QrInfo.fromMap(Map<String, dynamic> map) {
    return QrInfo(
      serial: map['serial'],
      myNum: (jsonDecode(map['myNum']) as List).map((e) => NumInfo.fromMap(e)).toList(),
    );
  }
}

class NumInfo {
  int? num1;
  int? num2;
  int?num3;
  int? num4;
  int? num5;
  int? num6;

  NumInfo({
    this.num1,
    this.num2,
    this.num3,
    this.num4,
    this.num5,
    this.num6,
  });

  Map<String, dynamic> toMap() {
    return {
      'num1': num1,
      'num2': num2,
      'num3': num3,
      'num4': num4,
      'num5': num5,
      'num6': num6,
    };
  }

  factory NumInfo.fromMap(Map<String, dynamic> map) {
    return NumInfo(
      num1: map['num1'],
      num2: map['num2'],
      num3: map['num3'],
      num4: map['num4'],
      num5: map['num5'],
      num6: map['num6'],
    );
  }

  String toJson() => jsonEncode(toMap());
  factory NumInfo.fromJson(String source) => NumInfo.fromMap(jsonDecode(source));
}

class selforigin{
  late Color? color;
  late int? number;

  selforigin ({this.color , this.number});

  @override
  String toString() {
    return 'numInfo{color: $color, number: $number}';
  }

}