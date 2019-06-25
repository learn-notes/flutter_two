# flutter_two

flutter学习笔记（二）--文件、json、网络请求、数据库

## 笔记简介

学习flutter文件、json、存储和网络四个方面过程中写的Demo

### 1.文件读写

文件读写分三个方面：读写权限、写入文件、读取文件

判断权限的demo中引用第三方库`simple_permissions`来控制权限的获取
```
simple_permissions: ^0.1.9
```
```
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
}
```

写入文件和读取文件前需先判断文件是否存在
```
bool exists = await file.exists();
if (exists) {
	/// 写入文件
	file.writeAsString('往文件中写入数据').then((String data) => print(data));
}

if (exists) {
	/// 读取文件
	file.readAsString().then((String data) => print(data));
}
```

### 2.Json数据解析
flutter也提供了json解析的API
```
import 'dart:convert';
```
把对象转换为Json数据的方法
```
Student stu = Student(1001, '三年一班', '张三');

var stuJsonStr = json.encode(stu);
print('stuJsonStr = $stuJsonStr');

var stus = [stu, stu, stu];
var stusJsonStr = json.encode(stus);
print('stusJsonStr = $stusJsonStr');
```
将json数据转换成对象
```
var stu = json.decode(stuJsonStr);

var stus = json.decode(stusJsonStr);
```

### 3.HTTP网络请求

隐引入三方库
```
http: ^0.12.0+2
```
以get请求为例
```
http.get("https://www.wanandroid.com/project/list/$pager/json?cid=294")
        .then((http.Response response) {
      var convertDataToJson = json.decode(response.body);
      convertDataToJson = convertDataToJson["data"]["datas"];
      //打印请求的结果
      print(convertDataToJson);
    });
```

### 4.数据库操作
引入三方库`sqflite`
```
sqflite: ^1.1.0
```
创建数据库
```
var databasesDir = await getExternalStorageDirectory();
print(databasesDir);
// 创建数据库文件，并返回地址
path = join(databasesDir.path + '/flutter/download', dbName);
```
删除数据库
```
await deleteDatabase(path);
```
对数据库进行操作前需要先打开数据库，操作完成后需要关闭数据库
```
// 打开数据库
Database database = await openDatabase(dbPath);
// 关闭数据库
await database.close();
```

建表
```
// 首先打开数据库
Database database = await openDatabase(dbPath, version: 1,onCreate: (Database db, int version) async {
	// 创建表
	await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
	print('创建数据库成功，创建表成功');
});
// 关闭数据库，每次操作完数据库后关闭
await database.close();
```
插入数据
```
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
```
更新数据
```
int count = await database.rawUpdate(
        'UPDATE Test SET name = ?, VALUE = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
```
查询数据
```
List<Map> list = await database.rawQuery('SELECT * FROM Test');
```
删除数据
```
// 删除所有 name ='another name' 的数据
int count = await database
        .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
// 删除全部数据
await database
        .rawDelete('DELETE FROM Test WHERE 1 = 1');
```
