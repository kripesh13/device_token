
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class FireStoreState extends ChangeNotifier {
  final fireStoreRef = FirebaseFirestore.instance.collection('user');
  TextEditingController messageControllerr = TextEditingController();


  bool isLoading = false;
  String id = DateTime.now().millisecondsSinceEpoch.toString();


  onSendData() async {
    isLoading = true;
    notifyListeners();
    await fireStoreRef.doc(id).set({
      "title": messageControllerr.text.toString(),
      "price": 50,
      "id": id,
    }).then((value) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
      messageControllerr.clear();
      notifyListeners();
    }).onError((error, stackTrace) {
      print(stackTrace);
    });

    isLoading = false;
    notifyListeners();
  }
}
