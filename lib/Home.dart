import 'package:flutter/material.dart';

import 'Demo1_file.dart';
import 'Demo2_json.dart';
import 'Demo3_http.dart';
import 'Demo4_database.dart';
import 'utils/LayoutPadding.dart';

void main() => runApp(MyApp());

///
/// 首页
///
/// @author : Joh Liu
/// @date : 2019/6/24 14:12
///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '首页',
      theme: ThemeData.light(),
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

        /// http请求 案例
        LayoutPadding.Layout(
          RaisedButton(
              child: Text('http请求'),
              onPressed: () {
                /// 页面跳转
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HttpDemo()));
              }),
        ),

        /// 数据库 案例
        LayoutPadding.Layout(
          RaisedButton(
              child: Text('数据库'),
              onPressed: () {
                /// 页面跳转
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => DatabaseDemo()));
              }),
        ),
      ],
    );
  }
}
