import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sekolahku/screens/form_screen.dart';
import 'package:flutter_sekolahku/screens/home_screen.dart';
import 'package:flutter_sekolahku/service/app_service.dart';

class DetailScreen extends StatefulWidget {
  final int idSiswa;
  final String name;
  final String firstName;
  final String lastName;
  final String telp;
  final String gender;
  final String grade;
  final String address;
  final List<String> hobbies;

  const DetailScreen(
      {Key key,
      this.name,
      this.telp,
      this.gender,
      this.grade,
      this.address,
      this.hobbies,
      this.idSiswa,
      this.firstName,
      this.lastName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          widget.name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FormScreen(
                    isEdit: true,
                    firstName: widget.firstName,
                    lastName: widget.lastName,
                    idSiswa: widget.idSiswa,
                    grade: widget.grade,
                    gender: widget.gender,
                    address: widget.address,
                    telp: widget.telp,
                    name: widget.name,
                    hobbies: widget.hobbies,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            width: 8,
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              AppService.getStudent.deleteStudent(widget.idSiswa).then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    ),
                  );
            },
          ),
          SizedBox(
            width: 4,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 8),
        children: [
          Center(
            child: Image.asset(
              widget.gender == "Perempuan"
                  ? "assets/images/wanita.png"
                  : "assets/images/pria.png",
              width: 150,
              height: 150,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.perm_contact_cal,
              size: 30,
            ),
            title: Text(
              widget.name,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("Nama"),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(
              Icons.call,
              size: 30,
            ),
            title: Text(
              widget.telp,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("No Telepon"),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_contact_cal,
              size: 30,
            ),
            title: Text(
              widget.gender,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("Jenis Kelamin"),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(
              Icons.stairs,
              size: 30,
            ),
            title: Text(
              widget.grade,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("Jenjang"),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(
              Icons.location_on,
              size: 30,
            ),
            title: Text(
              widget.address,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("Alamat"),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              size: 30,
            ),
            title: Text(
              widget.hobbies.toString().replaceAll("[", "").replaceAll("]", ""),
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("Hobi"),
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
