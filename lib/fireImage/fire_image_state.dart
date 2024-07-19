import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FireImageState extends ChangeNotifier {
  File? image;
  bool isLoading = false;
  final firebaseRef = FirebaseDatabase.instance.ref('post');

  pickImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  final storage = FirebaseStorage.instance;

  addPhotoToFireBase() async {
    if (image == null) return;

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = storage.ref().child('folderName/$id');

    isLoading = true;
    notifyListeners();

    try {
      UploadTask uploadTask = storageRef.putFile(image!.absolute);
      TaskSnapshot taskSnapshot = await uploadTask;
      String newUrl = await taskSnapshot.ref.getDownloadURL();

      await firebaseRef.child(id).set({
        "id": id,
        "title": newUrl,
      });
    } catch (e) {
      print('Upload error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
