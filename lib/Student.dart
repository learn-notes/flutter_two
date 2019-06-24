import 'package:flutter/material.dart';

///
/// 学生实体类
///
/// @author : Joh Liu
/// @date : 2019/6/24 17:47
///
class Student {
  int no;
  String cls;
  String name;

  Student(this.no, this.cls, this.name);

  @override
  String toString() {
    return 'Student{no: $no, cls: $cls, name: $name}';
  }

  Map<String, dynamic> toJson() => {
        'no': no,
        'cls': cls,
        'name': name,
      };
}
