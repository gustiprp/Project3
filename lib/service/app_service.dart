import 'package:flutter_sekolahku/model/model.dart';
import 'package:flutter_sekolahku/repository/student_repository.dart';
import 'package:flutter_sekolahku/service/student_service.dart';
import 'package:sqflite/sqflite.dart';

StudentService _studentService = StudentService(StudentRepository(Model.getInstance()));

class AppService{

  static StudentService get getStudent => _studentService;

  static Future<Database> openDB(){
    return Model().opendDB();
  }

  static Future<void> closeDB(){
    return Model().closeDB();
  }
}