import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'utils/DbUtils.dart';
import 'utils/LayoutPadding.dart';

///
/// 数据库
///
/// @author : Joh Liu
/// @date : 2019/6/25 10:24
///
class DatabaseDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DatabaseState();
  }
}

class _DatabaseState extends State<DatabaseDemo> {
  /// 获取数据库地址
  String dbPath = new DbUtils().createNewDb().toString();

  // 数据展示
  var _result = '暂无数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数据库'),
        centerTitle: true,
      ),
      body: LayoutPadding.Layout(
        ListView(
          children: <Widget>[
            /// 创建数据库和表
            RaisedButton(
              child: Text('创建数据库'),
              onPressed: () {
                _create();
              },
            ),

            /// 添加数据
            RaisedButton(
              child: Text('添加数据'),
              onPressed: () {
                _insert();
              },
            ),
            RaisedButton(
              child: Text('添加数据2'),
              onPressed: () {
                _insert2();
              },
            ),

            /// 查询数据
            RaisedButton(
              child: Text('查询数据'),
              onPressed: () {
                _query();
              },
            ),

            /// 更新数据
            RaisedButton(
              child: Text('更新数据'),
              onPressed: () {
                _update();
              },
            ),

            /// 删除数据
            RaisedButton(
              child: Text('删除数据'),
              onPressed: () {
                _delete();
              },
            ),

            /// 删除所有数据
            RaisedButton(
              child: Text('删除所有数据'),
              onPressed: () {
                _deleteAll();
              },
            ),

            //数据展示
            Text('$_result')
          ],
        ),
      ),
    );
  }

  /// 创建表
  _create() async {
    // 首先打开数据库
    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      // 创建表
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
      print('创建数据库成功，创建表成功');
    });
    // 关闭数据库，每次操作完数据库后关闭
    await database.close();

    setState(() {
      _result = '创建表：创建数据库成功，创建表成功';
    });
  }

  /// 插入数据库
  _insert() async {
    Database database = await openDatabase(dbPath);
    int id1, id2;
    await database.transaction((txn) async {
      // 插入数据并返回主键
      id1 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
      print('inserted1:$id1');
      id2 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
          ['another name', 12345678, 3.1416]);
      print('inserted2:$id2');
    });
    await database.close();

    setState(() {
      _result = '插入数据：$id1\t$id2';
    });
  }

  //不适用SQL语句的添加方式
  _insert2() async {
    Database database = await openDatabase(dbPath);
    Batch batch = database.batch();
    batch.insert(
        'Test', {'name': 'new_item name', 'value': 4444, 'num': 987.456});

    // batch.update('Test', {'name': 'new_item'}, where: 'name = ?', whereArgs: ['item']);
    // batch.delete('Test', where: 'name = ?', whereArgs: ['item']);
    setState(() {
      var results = batch.commit().toString();
      _result = '结果：$results';
    });
    await database.close();
  }

  /// 更新数据库
  _update() async {
    Database database = await openDatabase(dbPath);
    // 返回更新数据的条数
    int count = await database.rawUpdate(
        'UPDATE Test SET name = ?, VALUE = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
    print('updated: $count');
    await database.close();

    setState(() {
      _result = '更新数据：$count';
    });
  }

  /// 查询数据
  _query() async {
    Database database = await openDatabase(dbPath);
    // 查询所有数据
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    print(list);

    // 查询表中数据总数
    int count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM Test'));
    print('数据总数：$count');

    await database.close();

    setState(() {
      _result = '查询数据：$list\n数据总数：$count';
    });
  }

  /// 删除表数据
  _delete() async {
    Database database = await openDatabase(dbPath);
    int count = await database
        .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
    print('删除数据：$count');
    await database.close();

    setState(() {
      _result = '删除数据：$count';
    });
  }

  /// 删除表内全部数据
  _deleteAll() async {
    Database database = await openDatabase(dbPath);
    int count = await database
        .rawDelete('DELETE FROM Test WHERE 1 = 1');
    await database.close();
    setState(() {
      _result = '删除数据：全部删除成功';
    });
  }
}
