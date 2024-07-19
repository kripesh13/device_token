import 'package:device_token/fireImage/fire_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FireImageScreen extends StatelessWidget {
  const FireImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FireImageState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextButton(
              onPressed: state.pickImage,
              child: Text('Pick Image'),
            ),
            Container(
              height: 150,
              width: 150,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: state.image != null
                  ? Image.file(state.image!.absolute)
                  : Text('No Image found'),
            ),
            InkWell(
              onTap: () {
                state.addPhotoToFireBase();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update Photo",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    state.isLoading == true
                        ? CircularProgressIndicator()
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
