import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DateTime currentBackPressTime;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30, top: 10),
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/sekolah.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: userNameController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Username Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: "Username"),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: "Password"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      if (userNameController.text.trim() == "admin" &&
                          passwordController.text.trim() == "password") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } else {
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              "Gagal Masuk, Bukan Admin",
                            ),
                          ),
                        );
                      }
                    } else {
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Silahkan isi seluruh data"),
                        ),
                      );
                    }
                  },
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
