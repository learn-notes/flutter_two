import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import "package:simple_permissions/simple_permissions.dart";

import 'utils/LayoutPadding.dart';


///
/// 文件使用案例
///
/// @author : Joh Liu
/// @date : 2019/6/24 14:14
///
class FileDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FileState();
  }
}

class _FileState extends State<FileDemo> {
  var msg;

  Permission permission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件案例'),
        centerTitle: true,
      ),
      body: LayoutPadding.Layout(
        ListView(
          children: <Widget>[
            /// 获取文件读写权限
            RaisedButton(
              child: Text('文件读写权限'),
              onPressed: () {
                _getPermission();
              },
            ),

            /// 查询文件是否存在
            RaisedButton(
              child: Text('文件是否存在'),
              onPressed: _press1,
            ),

            /// 写入文件，文件不存在，创建再写入
            RaisedButton(
              child: Text('写入文件'),
              onPressed: _press2,
            ),

            /// 读取文件
            RaisedButton(
              child: Text('读取文件'),
              onPressed: _press3,
            ),
          ],
        ),
      ),
    );
  }

  /// 判断文件是否存在
  void _press1() async {
    // 打印日志
    var tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir.path + '/YaSha/download/CloudLink.apk';
    var file = File(tempPath);
    try {
      bool exists = await file.exists();
      if (exists) {
        debugPrint('----文件存在----');
      } else {
        debugPrint('----文件不存在----');
      }
    } catch (e) {
      print(e);
    }
  }

  /// 写入文件
  void _press2() async {
    var tempDir = await getExternalStorageDirectory();
    try {
      /// 文件的读写操作
      Directory(tempDir.path).create(recursive: true).then((Directory d) {
        return new File(d.path + "/YaSha/download/test1.txt")
            .create(recursive: true)
            .then((File file) {
          file.writeAsString('123456这是添加数据123456').then((File file) {
            print('----数据写入完成----');
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  /// 文件读取
  void _press3() async {
    var tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir.path + '/YaSha/download/test1.txt';
    var file = File(tempPath);
    try {
      bool exists = await file.exists();
      if (exists) {
        file.readAsString().then((String data) => print(data));
      }
    } catch (e) {
      print(e);
    }
  }

  /// 得到权限
  Future _getPermission() async {
    //如果是android的话
    if (Platform.isAndroid) {
      //读写sd的权限
      bool readPermission = await SimplePermissions.checkPermission(
          Permission.ReadExternalStorage);
      bool writePermission = await SimplePermissions.checkPermission(
          Permission.WriteExternalStorage);

      //如果没有读的权限的话 请求权限
      if (!readPermission) {
        await SimplePermissions.requestPermission(
            Permission.ReadExternalStorage);
      }

      //如果没有写的权限的话 请求权限
      if (!writePermission) {
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);
      }

      if (readPermission && writePermission) {
        debugPrint('----已有文件读写权限！！！----');
      }
    }
  }
}
