import 'package:flutter/material.dart';
import 'dart:convert';
import 'pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Json Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';
  int _counter = 0;
  int appCounter = 0;
  String documentsPath = '';
  String tempPath = '';
  List<Pizza> myPizzas = [];
  late File myFile;
  String fileText='';
  final pwdController = TextEditingController();
  String myPass = '';
  final storage = new FlutterSecureStorage();
  final myKey = 'myPass';


  Future<List<Pizza>> readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzalist.json');
    List pizzaMapList = jsonDecode(myString);
    List<Pizza> myPizzas = [];
    for (var pizza in pizzaMapList) {
      Pizza myPizza = Pizza.fromJson(pizza);
      myPizzas.add(myPizza);
    }
    String json = convertToJSON(myPizzas);
    print(json);
    return myPizzas;
  }

  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => jsonEncode(pizza)).toList());
  }

  Future readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;
    await prefs.setInt('appCounter', appCounter);
    setState(() {
      appCounter = appCounter;
    });
  }

  Future deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  Future getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
  }
  Future<bool> writeFile() async {
    try {
      await myFile.writeAsString('Margherita, Capricciosa, Napoli');
      return true;
    }catch(e){
      return false;
    }
  }
  Future<bool> readFile() async {
    try {
      String fileContent = await myFile.readAsString();
      setState((){
        fileText = fileContent;
      });
      return true;
    }catch(e){
      return false;
    }
  }

  Future writeToSecureStorage() async{
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String> readFromSecureStorage() async{
    String secret = await storage.read(key: myKey) ?? '';
    return secret;
  }


  @override
  void initState() {
  
    // readJsonFile().then((value) {
    //   setState(() {
    //     myPizzas = value;
    //   });
    // });
    // // readAndWritePreference();
    // getPaths().then((_){
    //   myFile = File('$documentsPath/pizzas.txt');
    //   writeFile();
    // });
      super.initState();
  }

  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //       title: Text('Shared Preferences'),
    //     ),
    //     // body: ListView.builder(
    //     //   itemCount: myPizzas.length,
    //     //   itemBuilder: (context, index){
    //     //     return ListTile(
    //     //       title: Text(myPizzas[index].pizzaName),
    //     //       subtitle: Text(myPizzas[index].description),
    //     //     );
    //     //   }
    //     // )
    //     body: Center(
    //         child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Text('You have opened this app $appCounter times'),
    //         ElevatedButton(
    //             onPressed: () {
    //               deletePreference();
    //             },
    //             child: Text('Reset counter'))
    //       ],
    //     )));
    // return Scaffold(
    //     appBar: AppBar(title: const Text('Path Provider')),
    //     body:
    //         Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       Text('Doc path: $documentsPath'),
    //       Text('Temp path: $tempPath'),
    //       ElevatedButton(
    //         child: const Text('Read File'),
    //         onPressed: () => readFile(),
    //       ),
    //       Text(fileText),
    //     ]));
    return Scaffold(
      appBar: AppBar(title: const Text('Path Provider')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            TextField(
              controller: pwdController,
            ),
            ElevatedButton(child: const Text('Save Value'), onPressed: (){writeToSecureStorage();}),
            ElevatedButton(child: const Text('Read Value'), onPressed: (){readFromSecureStorage().then((value){
              setState(() {
                myPass = value;
              });
            });}),
            Text(myPass)
          ],)
        )
      )
    );
  }
}