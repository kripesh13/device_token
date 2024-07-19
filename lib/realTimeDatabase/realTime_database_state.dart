import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealTimeDataBase extends ChangeNotifier {
  TextEditingController messageControllerr = TextEditingController();
  bool isLoading = false;
  final firebaseRef = FirebaseDatabase.instance.ref('post');

  String id = DateTime.now().millisecondsSinceEpoch.toString();
  onSendData() async {
    isLoading = true;
    notifyListeners();
    await firebaseRef.child(id).set({
      "title": messageControllerr.text.toString(),
      "price": 50,
      "id": id,
    }).then((value) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
      messageControllerr.clear();
      notifyListeners();
    });

    isLoading = false;
    notifyListeners();
  }
}
