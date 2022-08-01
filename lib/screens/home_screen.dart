// ignore_for_file: prefer_const_constructors, camel_case_types, unnecessary_this, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addprop_screen.dart';
import 'package:flutter_application_1/screens/drawer.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/registration_screen.dart';
import 'package:flutter_application_1/search_screen/search_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinuser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedinuser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/images.jpg", fit: BoxFit.contain),
              ),
              Text(
                "Welcome to Property Finder",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedinuser.firstname} ${loggedinuser.secondname}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("${loggedinuser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ActionChip(
                      label: Text("Sell"),
                      labelStyle: TextStyle(
                        color: Colors.blueAccent
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>addProperty()));
                      }),
                  const SizedBox(width: 20,),
                  ActionChip(
                      labelStyle: TextStyle(
                          color: Colors.blueAccent
                      ),
                      label: Text("Buy"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchProperty()));;
                      }),
                ],
              ),
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Logged out");
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
      drawer: NavigationDrawerWidget(
          name: "${loggedinuser.firstname} ${loggedinuser.secondname}",
          email: "${loggedinuser.email}"),
    );
  }

  void logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => loginscreen()));
  }
}