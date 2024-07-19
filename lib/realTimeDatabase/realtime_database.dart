import 'package:device_token/realTimeDatabase/realTime_database_state.dart';
import 'package:device_token/showData/show_data.dart';
import 'package:device_token/showData/show_data_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RealTimeDatabseScreen extends StatelessWidget {
  const RealTimeDatabseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RealTimeDataBase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Time data base"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
                          child: const ShowData(),
                          create: (_) => ShowDataState(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
