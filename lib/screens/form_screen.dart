import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sekolahku/domain/student.dart';
import 'package:flutter_sekolahku/screens/home_screen.dart';
import 'package:flutter_sekolahku/service/app_service.dart';
import 'package:flutter_sekolahku/util/capitalize.dart';
import 'package:flutter_sekolahku/widgets/checkbox_custom.dart';
import 'package:flutter_sekolahku/widgets/radio_custom.dart';

class FormScreen extends StatefulWidget {
  final bool isEdit;
  final int idSiswa;
  final String name;
  final String firstName;
  final String lastName;
  final String telp;
  final String gender;
  final String grade;
  final String address;
  final List<String> hobbies;

  const FormScreen(
      {Key key,
      this.isEdit,
      this.idSiswa,
      this.name,
      this.telp,
      this.gender,
      this.grade,
      this.address,
      this.hobbies,
      this.firstName,
      this.lastName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FromScreenState();
  }
}

class FromScreenState extends State<FormScreen> {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  static const genders = Student.genders;
  static const grades = Student.grades;
  static const hobbies = Student.hobbiesList;
  var gender, grade;
  List<String> resultHobbies = [];

  TextEditingController namaDepanController = TextEditingController();
  TextEditingController namaBelakangController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      namaDepanController.text = widget.firstName;
      namaBelakangController.text = widget.lastName;
      alamatController.text = widget.address;
      noHpController.text = widget.telp;
      gender = widget.gender;
      grade = widget.grade;
      resultHobbies = widget.hobbies;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff203878),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.isEdit ? "Edit Data" : "Tambah Data",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: namaDepanController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*Tidak Boleh Kosong";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: "Nama Depan"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: namaBelakangController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*Tidak Boleh Kosong";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: "Nama Belakang"),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: noHpController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return "*Tidak Boleh Kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "No. HP"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Jenis Kelamin",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            Row(
              children: genders
                  .map(
                    (e) => RadioCustom<String>(
                      value: e,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      groupValue: gender,
                      label: Text(capitalize(e)),
                      activeColor: Colors.amber,
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: DropdownButton<String>(
                value: grade,
                hint: Text("Pilih jenjang"),
                items: grades
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.toUpperCase()),
                        ))
                    .toList(),
                isExpanded: true,
                onChanged: (String value) {
                  setState(() {
                    grade = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Hobi",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Column(
              children: hobbies
                  .map((e) => CheckBoxCustom(
                        label: e,
                        onChanged: (value) {
                          setState(() {
                            if (resultHobbies.contains(e)) {
                              resultHobbies.remove(e);
                            } else {
                              resultHobbies.add(e);
                            }
                          });
                        },
                        value: resultHobbies.contains(e),
                      ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                controller: alamatController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return "*Tidak Boleh Kosong";
                  }
                  return null;
                },
                maxLines: 4,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Alamat",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.save, color: Colors.white,),
        onPressed: () {
          if (gender != null &&
              grade != null &&
              resultHobbies.length > 0 &&
              formKey.currentState.validate()) {
            Student student = Student();
            student.firstName = namaDepanController.text.trim();
            student.lastName = namaBelakangController.text.trim();
            student.hobbies = resultHobbies;
            student.address = alamatController.text.trim();
            student.gender = gender;
            student.grade = grade;
            student.mobilePhone = noHpController.text.trim();

            if (widget.isEdit) {
              AppService.getStudent
                  .updateStudent(widget.idSiswa, student)
                  .then((value) {
                scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text("Sukses Edit data")));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              });
            } else {
              AppService.getStudent
                  .createStudent(student)
                  .then((value) {
                scaffoldKey.currentState
                    .showSnackBar(SnackBar(content: Text("Sukses")));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              });
            }
          } else {
            scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("*Silahkan isi semua data"),
              ),
            );
          }
        },
      ),
    );
  }
}
