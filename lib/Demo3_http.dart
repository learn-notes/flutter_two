import 'package:flutter/material.dart';

import 'utils/LayoutPadding.dart';

///
/// http请求
///
/// @author : Joh Liu
/// @date : 2019/6/25 10:24
///
class HttpDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HttpState();
  }
}

class _HttpState extends State<HttpDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('http请求'),
        centerTitle: true,
      ),
      body: LayoutPadding.Layout(
        ListView(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
