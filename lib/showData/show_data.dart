import 'package:device_token/showData/show_data_state.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowData extends StatelessWidget {
  const ShowData({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ShowDataState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Show data'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: state.searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Search..',
              ),
              onChanged: (value) {
                state.onSearch(value);
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: state.ref,
              defaultChild: CircularProgressIndicator(
                color: Colors.red,
              ),
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                if (state.searchController.text.isEmpty) {
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            title: Text('Edit'),
                            leading: Icon(Icons.edit),
                            onTap: () {
                              Navigator.of(context).pop(); // Close the menu
                              state.showInputDialog(context, title,
                                  snapshot.child('id').value.toString());
                            },
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              state.ref
                                  .child(snapshot.child('id').value.toString())
                                  .remove();
                              Navigator.pop(context);
                            },
                            title: Text('Delete'),
                            leading: Icon(Icons.delete_outline),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(state.searchController.text.toLowerCase())) {
                  return ListTile(
                    title: Text(title),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
