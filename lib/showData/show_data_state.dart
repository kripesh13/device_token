import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowDataState extends ChangeNotifier {
  ShowDataState();
  final ref = FirebaseDatabase.instance.ref('post');


  final TextEditingController searchController = TextEditingController();
  final TextEditingController updateController = TextEditingController();

  onSearch(value) {
    notifyListeners();
  }

  void showInputDialog(BuildContext context, String title, String id) {
    final _formKey = GlobalKey<FormState>();
    String _inputValue = '';
    updateController.text = title;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Dialog'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: updateController,
              decoration: InputDecoration(
                labelText: 'Enter your value',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                _inputValue = value!;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print('Input value: $_inputValue');
                  Navigator.of(context).pop();
                  ref.child(id).update({
                    "title": updateController.text.toString(),
                  }).then((value) {
                    if (kDebugMode) {
                      print("update successfull");
                    }
                  }).onError((error, stackTrace) {
                    if (kDebugMode) {
                      print(error.toString().toString());
                    }
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
