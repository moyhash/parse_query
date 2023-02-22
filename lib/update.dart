import 'package:flutter/material.dart';
import 'package:parse_project/function.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: FutureBuilder<List<ParseObject>>(
        future: selectUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final employee = snapshot.data![index];
                final userAge = employee.get<int>('age')!.toString();
                final userName = employee.get<String>('name')!; //.trim()[0]
                final userMail = employee.get<String>('email')!;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    child: Text(userAge),
                  ),
                  title: Text(userName),
                  subtitle: Text(userMail),
                  trailing: FittedBox(
                    //fit: BoxFit.fill,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              (Icons.person_add),
                              color: Colors.green,
                              size: 40,
                            ),
                            onPressed: () {
                              // function here
                              //updateUser(employee.objectId!);
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(
                              (Icons.clear),
                              color: Colors.red,
                              size: 35,
                            ),
                            onPressed: () async {
                              // function here
                              deleteUser(employee.objectId!);
                              setState(() {
                                // refresh the screen after delete
                                //_adresseItem = HiveHelper.getAdresses();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
