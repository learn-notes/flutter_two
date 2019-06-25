///
/// 学生实体类
///
/// @author : Joh Liu
/// @date : 2019/6/24 17:47
///
class Student {
  int no;
  String cls;
  String name;

  Student(this.no, this.cls, this.name);

  @override
  String toString() {
    return 'Student{no: $no, cls: $cls, name: $name}';
  }

  Student.fromJson(Map<String, dynamic> map)
      : no = map['no'],
        cls = map['cls'],
        name = map['name'];

  Map<String, dynamic> toJson() => {
        'no': no,
        'cls': cls,
        'name': name,
      };
}
