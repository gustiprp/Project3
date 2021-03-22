import 'package:flutter_sekolahku/util/capitalize.dart';

class Student {
  static const genders = ["Laki - laki", "Perempuan"];
  static const grades = ["TK", "SD", "SMP", "SMA"];
  static const hobbiesList = ["Membaca", "Bermain Bola", "Melukis"];

  int idSiswa;
  String firstName;
  String lastName;
  String grade;
  String mobilePhone;
  String gender;
  String address;
  List<String> hobbies = <String>[];

  String get fullname {
    return "${capitalize(firstName)} ${capitalize(lastName)}";
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'mobile_phone': mobilePhone,
      'grade': grade,
      'gender': gender,
      'address': address,
      'hobbies': hobbies.join(", "),
    };
    return map;
  }

  fromMap(Map<String, dynamic> map) {

    idSiswa = map['id_siswa'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    grade = map['grade'];
    mobilePhone = map['mobile_phone'];
    gender = map['gender'];
    address = map['address'];
    hobbies = map['hobbies'] is String ? map['hobbies'].split(', ') : [];
  }
}
