import 'dart:convert';

import 'package:flutter/material.dart';

import 'LayoutPadding.dart';
import 'Student.dart';

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
  var jsonStr = "{'no':1001,'cls':'3年1班','name':'张三'}";

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
            Text(jsonStr),

            /// 解析Json字符串
            RaisedButton(
              child: Text('转Json数据'),
              onPressed: () {
                _toJson();
              },
            ),
          ],
        ),
      ),
    );
  }

  _toJson() {
    Student obj = json.decode(jsonStr);
    jsonStr = obj.name + ";" + obj.cls + ';' + obj.no.toString();
  }
}
