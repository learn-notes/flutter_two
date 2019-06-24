import 'package:flutter/material.dart';

import 'Demo1_file.dart';
import 'Demo2_json.dart';
import 'LayoutPadding.dart';

void main() => runApp(MyApp());

///
/// 首页
///
/// @author : Joh Liu
/// @date : 2019/6/24 14:12
///
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '首页',
      home: new Scaffold(
        appBar: AppBar(
          title: Text('首页'),
          centerTitle: true,
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        /// flutter文件操作 案例
        LayoutPadding.Layout(
          RaisedButton(
              child: Text('文件案例'),
              onPressed: () {
                /// 页面跳转
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FileDemo()));
              }),
        ),

        /// json解析 案例
        LayoutPadding.Layout(
          RaisedButton(
              child: Text('Json解析'),
              onPressed: () {
                /// 页面跳转
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => JsonDemo()));
              }),
        ),


      ],
    );
  }
}
