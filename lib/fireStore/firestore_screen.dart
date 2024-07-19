import 'package:device_token/FirestoreDataShow/fire_base_show.dart';
import 'package:device_token/FirestoreDataShow/fire_base_show_state.dart';
import 'package:device_token/fireStore/fire_store_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FireStoreScreen extends StatelessWidget {
  const FireStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FireStoreState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Store '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: 4,
              controller: state.messageControllerr,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Write some things',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  state.onSendData();
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
                        "Post Data",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      state.isLoading == true
                          ? CircularProgressIndicator(
                              color: Colors.red,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        child: const FireBaseShowDataScreen(),
                        create: (_) => FireBaseShowState(),
                      ),
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "show Data",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
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
