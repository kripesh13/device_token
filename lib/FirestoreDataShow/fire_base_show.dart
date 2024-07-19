import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_token/FirestoreDataShow/fire_base_show_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FireBaseShowDataScreen extends StatelessWidget {
  const FireBaseShowDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FireBaseShowState>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Show data'),
        ),
        body: Column(children: [
          StreamBuilder<QuerySnapshot>(
            stream: state.fireStoreRef,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                Text(snapshot.error.toString());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle:
                          Text(snapshot.data!.docs[index]['id'].toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: ListTile(
                              title: Text('Edit'),
                              leading: Icon(Icons.edit),
                              onTap: () {
                                Navigator.of(context).pop(); // Close the menu
                                state.showInputDialog(
                                    context,
                                    snapshot.data!.docs[index]['title']
                                        .toString(),
                                    snapshot.data!.docs[index]['id']
                                        .toString());
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              onTap: () {
                                state.ref
                                    .doc(snapshot.data!.docs[index]['id'])
                                    .delete();

                                Navigator.pop(context);
                              },
                              title: Text('Delete'),
                              leading: Icon(Icons.delete_outline),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )
        ]));
  }
}
