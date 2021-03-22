import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sekolahku/domain/student.dart';
import 'package:flutter_sekolahku/screens/form_screen.dart';
import 'package:flutter_sekolahku/service/app_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;
  String searchValue;

  bool isSearch = false;

  Widget titleBar = Text(
    "SekolahKu",
    style: TextStyle(
      color: Colors.white,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff203878),
        automaticallyImplyLeading: false,
        title: titleBar,
        actions: [
          IconButton(
            icon: Icon(
              isSearch ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              if (!isSearch) {
                setState(() {
                  isSearch = true;
                  titleBar = Container(
                    alignment: Alignment.center,
                    height: 45,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Cari Siswa",
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          searchValue = value;
                        });
                      },
                    ),
                  );
                });
              } else {
                setState(() {
                  isSearch = false;
                  titleBar = Text(
                    "SekolahKu",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                });
              }
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            Fluttertoast.showToast(msg: 'Tap back again to leave');
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: FutureBuilder<List<Student>>(
          future: AppService.getStudent.getAllStudent(searchValue),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Text("Tidak ada data");
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    snapshot.data[index].gender == "Perempuan"
                        ? "assets/images/wanita.png"
                        : "assets/images/pria.png",
                  ),
                  title: Text(snapshot.data[index].fullname),
                  subtitle: Text(snapshot.data[index].gender),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data[index].grade),
                      SizedBox(
                        height: 8,
                      ),
                      Text(snapshot.data[index].mobilePhone),
                    ],
                  ),
                  onTap: () {
                    print(snapshot.data[index].firstName);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            idSiswa: snapshot.data[index].idSiswa,
                            name: snapshot.data[index].fullname,
                            firstName: snapshot.data[index].firstName,
                            lastName: snapshot.data[index].lastName,
                            telp: snapshot.data[index].mobilePhone,
                            address: snapshot.data[index].address,
                            gender: snapshot.data[index].gender,
                            grade: snapshot.data[index].grade,
                            hobbies: snapshot.data[index].hobbies,
                          ),
                        ));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                );
              },
              itemCount: snapshot.data.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(
                isEdit: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
