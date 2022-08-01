// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/registration_screen.dart';

import '../search_screen/components/adtile.dart';

class myproperty extends StatefulWidget {
  const myproperty({Key? key}) : super(key: key);

  @override
  State<myproperty> createState() => _mypropertyState();
}

class _mypropertyState extends State<myproperty> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(loggedInUser.firstname?.toUpperCase()??""),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage("https://i.pinimg.com/originals/06/81/39/068139bff0b22024e775bfcbb42ed3b4.jpg"),
                      radius: 40,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15, left: 5),
                  child: Text(
                    "${loggedInUser.firstname} ${loggedInUser.secondname}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1, left: 5),
                  child: Text(
                    loggedInUser.email??"",
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('ads')
                  .where('uid', isEqualTo:user!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  );
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/3),
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];

                      return  AdTile(
                          snap: snap);
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
