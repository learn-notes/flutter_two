import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  var dbName = 'flutterdemo.db';
  String path;

  DbUtils();

  /// 创建数据库
  Future<String> createNewDb() async {
    var databasesDir = await getExternalStorageDirectory();
    print(databasesDir);
    // 创建数据库文件，并返回地址
    path = join(databasesDir.path + '/flutter/download', dbName);

    if (await Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  /// 删除数据库
  deleteDb() async{
    if(path!=null) {
      await deleteDatabase(path);
    }
  }
}
