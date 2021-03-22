import 'package:flutter_sekolahku/domain/student.dart';
import 'package:flutter_sekolahku/repository/student_repository.dart';

class StudentService{
  StudentRepository _studentRepository;

  StudentService(this._studentRepository);

  Future<List<Student>> getAllStudent(String searchValue){
    return _studentRepository.readStudent(searchValue);
  }

  Future deleteStudent(int index){
   return _studentRepository.deleteStudent(index);
  }

  Future<int> createStudent(Student student){
    return _studentRepository.createStudent(student);
  }

  Future<int> updateStudent(int id, Student student){
    return _studentRepository.updateStudent((id), student);
  }
}