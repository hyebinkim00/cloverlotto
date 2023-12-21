import 'package:flutter/material.dart';

class qrPqge {
  String? serial;
  String? date;
  List<numInfo>? winNum;
  List<numInfo>? myNum;
}

class numInfo{
  late Color? color;
  late int? number;

  numInfo ({this.color , this.number});

  @override
  String toString() {
    return 'numInfo{color: $color, number: $number}';
  }
}