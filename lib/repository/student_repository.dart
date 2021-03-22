import 'package:flutter_sekolahku/domain/student.dart';
import 'package:flutter_sekolahku/model/model.dart';

class StudentRepository {

  Model model;

  StudentRepository(this.model);

  Future<int> createStudent(Student student) {
    return model.getDatabase().then((db) =>
        db.insert("tabel_siswa", student.toMap()));
    // students.add(student);
  }

  Future <List<Student>> readStudent([String searchValue]) async {
    var sql = '''
    SELECT * FROM tabel_siswa
    ''';

    if(searchValue != null){
      var value= '%$searchValue%';
      sql += '''
      WHERE first_name LIKE '$value' OR 
      last_name LIKE '$value' OR
      mobile_phone LIKE '$value' OR
      grade LIKE '$value' OR
      gender LIKE '$value' OR
      address LIKE '$value'
      ''';
    }

    return model.getDatabase().then((db) => db.rawQuery(sql)).then((data) {
      if (data.length == 0) {
        return [];
      }
      List<Student> students = [];
      for (int i = 0; i < data.length; i++) {
        Student student = Student();
        student.fromMap(data[i]);
        students.add(student);
      }
      return students;
    });
  }

  Future<int> updateStudent(int id, Student student) async {
    return model.getDatabase().then((db) =>
        db.update('tabel_siswa', student.toMap(), where: 'id_siswa = $id'));
  }

  Future<void> deleteStudent(int index) {
    var sql = '''
  
  DELETE FROM tabel_siswa WHERE id_siswa = ?
    
  ''';
    return model.getDatabase().then((db) => db.execute(sql, [index]));
  }
}
