import 'package:flutter/material.dart';
//import 'package:parse_project/function.dart';
import 'package:parse_project/update.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = '9YahmBGpxwJDeFwzw0ka3gwfQuObr8jG05U6VUVD';
  const keyClientKey = 'YaoYnpwms7ExuFW8AgIvNBsMVb9hQkmw1V34Deyk';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controlId = TextEditingController();
  final controlName = TextEditingController();
  final controlAge = TextEditingController();
  final controlEmail = TextEditingController();
  final controlPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('PARSE CRUD PROJECT'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 160,
                child: Image.network(
                    'https://parsefiles.back4app.com/9YahmBGpxwJDeFwzw0ka3gwfQuObr8jG05U6VUVD/5f783225df03b286056d2e7fbce9e0b8_logo_login.png'),
              ),
              const Center(
                child: Text('User Registration',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: controlName,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Name'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: controlAge,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Age'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: controlEmail,
                //obscureText: true,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Email'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: controlPhone,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Phone'),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    ElevatedButton(
                      child: const Text(
                        'Enregitrer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => addUser(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      //onPressed: () => updateUser(controlId.text),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenTwo(),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Ajouter un Employee
  void addUser() async {
    if (controlName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Empty name"),
        duration: Duration(seconds: 2),
      ));
      return;
    } else {
      final user = ParseObject('Employee')
        ..set('name', controlName.text)
        ..set('age', int.parse(controlAge.text))
        ..set('email', controlEmail.text)
        ..set('phone', controlPhone.text);
      await user.save();
    }
    setState(() {
      controlName.clear();
      controlAge.clear();
      controlEmail.clear();
      controlPhone.clear();
    });
  }

  // Update User
  Future<void> updateUser(String id) async {
    //await Future.delayed(Duration(seconds: 1), () {});
    var todo = ParseObject('Todo')
      ..objectId = id
      ..set('name', controlName.text)
      ..set('age', controlName.text)
      ..set('email', controlName.text)
      ..set('phone', controlName.text);
    await todo.save();
  }

/*   void addUser() async {
    final user = ParseObject('Employee');
    if (controlName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Empty title"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await saveUser(controlName.text, int.parse(controlAge.text),
        controlEmail.text, controlPhone.text);
        await user.save();
    setState(() {
      controlName.clear();
      controlAge.clear();
      controlEmail.clear();
      controlPhone.clear();
    });
  } */

/*   Future<void> saveUser(
      String name, int age, String email, String phone) async {
    //await Future.delayed(Duration(seconds: 1), () {});
    final user = ParseObject('Employee')
      ..set('name', name)
      ..set('age', age)
      ..set('email', email)
      ..set('phone', phone);
    await user.save();
  } */
}
