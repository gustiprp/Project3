import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Model _model;

class Model {

  static Model getInstance(){
    if (_model != null && _model is Model){
      return _model;
    }

    _model = Model();

    return _model;
  }

  Database database;

  Future<Database> opendDB() async {
    var databaseDirectory = await getDatabasesPath();

    try {
      await Directory(databaseDirectory).create(recursive: true);
      print("Direktori dibuat");
    } catch (error) {
      print("Direktori sudah ada");
    }

    var path = join(databaseDirectory, "student_db");

    database = await openDatabase(
      path,
      onCreate: (db, version) {
        String sql = '''
          CREATE TABLE IF NOT EXISTS tabel_siswa(
          id_siswa INTEGER PRIMARY KEY NOT NULL,
          first_name TEXT(50),
          last_name TEXT(50),
          mobile_phone TEXT(13),
          address TEXT(50),
          gender TEXT(11),
          grade TEXT(3),
          hobbies TEXT(50)
          );
          ''';
        db.execute(sql);
      },
      version: 1,
    );
    return database;
  }

  Future<void> closeDB() {
    return database.close();
  }

  Future<Database> getDatabase() async {
    var databaseDirectory = await getDatabasesPath();

    try {
      await Directory(databaseDirectory).create(recursive: true);
      print("Direktori dibuat");
    } catch (error) {
      print("Direktori sudah ada");
    }

    var path = join(databaseDirectory, "student_db");

    database = await openDatabase(
      path,
      onCreate: (db, version) {
        String sql = '''
          CREATE TABLE IF NOT EXISTS tabel_siswa(
          id_siswa INTEGER PRIMARY KEY NOT NULL,
          first_name TEXT(50),
          last_name TEXT(50),
          mobile_phone TEXT(13),
          address TEXT(50),
          gender TEXT(11),
          grade TEXT(3),
          hobbies TEXT(50)
          );
          ''';
        db.execute(sql);
      },
      version: 1,
    );
    return database;
  }
}
