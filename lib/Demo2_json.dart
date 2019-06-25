import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/Student.dart';
import 'utils/LayoutPadding.dart';

///
/// Json解析
///
/// @author : Joh Liu
/// @date : 2019/6/24 17:40
///
class JsonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JsonState();
  }
}

class _JsonState extends State<JsonDemo> {
  /// json字符串
  var stuJsonStr;
  var stusJsonStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json解析'),
        centerTitle: true,
      ),
      body: LayoutPadding.Layout(
        ListView(
          children: <Widget>[
            Text('json数据'),

            /// Json解析
            RaisedButton(
              child: Text('Json解析'),
              onPressed: () {
                Student stu = Student(1001, '三年一班', '张三');
                Map maps = stu.toJson();
                print('stu = $maps');

                stuJsonStr = json.encode(stu);
                print('stuJsonStr = $stuJsonStr');

                var stus = [stu, stu, stu];
                stusJsonStr = json.encode(stus);
                print('stusJsonStr = $stusJsonStr');
              },
            ),

            /// 解析Json字符串
            RaisedButton(
              child: Text('转Json数据'),
              onPressed: () {
                var stu = json.decode(stuJsonStr);
                print('stu.runtimeType = ${stu.runtimeType}');
                Student stu2 = Student.fromJson(stu);
                print('stu2 = $stu2');

                var stus = json.decode(stusJsonStr);
                print('stus.runtimeType = ${stus.runtimeType}');
                var stus2 = <Student>[];
                for (var map in stus) {
                  stus2.add(Student.fromJson(map));
                }
                print('stus2 = $stus2');
              },
            ),
          ],
        ),
      ),
    );
  }
}
