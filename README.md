# flutter_two

flutter学习笔记（二）

## 笔记简介

学习flutter文件、存储和网络三个方面过程中写的Demo

### 1.文件读写

文件读写分三个方面：读写权限、写入文件、读取文件

判断权限的demo中引用第三方插件`simple_permissions`来控制权限的获取

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

### 2.