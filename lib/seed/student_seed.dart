import 'package:faker/faker.dart';
import 'package:flutter_sekolahku/domain/student.dart';

class StudentSeed{
  var seed = Faker();


  Student getFaker() {
    var student = Student();
    student.firstName = seed.person.firstName();
    student.lastName = seed.person.lastName();
    student.address = seed.address.streetAddress();
    student.gender = Student.genders[seed.randomGenerator.integer(2)];
    student.grade = Student.grades[seed.randomGenerator.integer(4)];
    student.hobbies = Student.hobbiesList;
    student.mobilePhone = "081287439480";

    return student;
  }

  List<Student> getStudent([int max = 10]){
    List<Student> students = <Student>[];
    for (int i = 0; i < max; i++) {
      students.add(this.getFaker());
    }
    return students;
  }
}