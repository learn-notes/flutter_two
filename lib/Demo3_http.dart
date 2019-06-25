import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/ArticRes.dart';

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
  List items = List();

  int pager = 0;

  @override
  Future initState() {
    // TODO: implement initState
    super.initState();
    _pullNet1(pager);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('http请求'),
        centerTitle: true,
      ),
      body: ListView(
          children: items.map((item) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                item["title"],
                maxLines: 1,
              ),
              subtitle: Text(
                item["desc"],
                maxLines: 3,
              ),
              trailing: Image.network(
                item["envelopePic"],
                height: 100,
              ),
            ),
          ),
          elevation: 3.0,
          margin: const EdgeInsets.all(10.0),
        );
      }).toList()),
    );
  }

  //获取数据
  _pullNet1(int pager) {
    http
        .get("https://www.wanandroid.com/project/list/$pager/json?cid=294")
        .then((http.Response response) {
      var convertDataToJson = json.decode(response.body);
      convertDataToJson = convertDataToJson["data"]["datas"];
      //打印请求的结果
      print(convertDataToJson);
      setState(() {
        items = convertDataToJson;
      });
    });
  }
}
