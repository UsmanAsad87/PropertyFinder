import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ad_model.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/repository/storage_methods.dart';
import 'package:flutter_application_1/screens/registration_screen.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadAd(
    String title,
    String type,
    String price,
    String area,
    String city,
    String desc,
    Uint8List file,
  ) async {
    String res = "Some error occurred";
    try {
      String adImageUrl = await StorageMethods().uploadImageToStorage('ads', file, true);

      String adId = const Uuid().v1();

      UserModel user = UserModel();
      await  FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        user = UserModel.fromMap(value.data());});

        AdModel ad = AdModel(
          title: title,
          uid: user.uid!,
          adId: adId,
          username: user.firstname!,
          adImageUrl: adImageUrl,
          resOrComm: type,
          area: area,
          city: city,
          price: price,
          description: desc,
          datePublished: DateTime.now(),
        );
        _firestore.collection('ads').doc(adId).set(ad.toJson());

        res = "success";

    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
