import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:async/async.dart';
import 'geolocation.dart';
import 'navigation_first.dart';
import 'navigation_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationDialog(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  Future<http.Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = 'books/v1/volumes/junbDwAAQBAJ';
    Uri url = Uri.https(authority, path);
    return await http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  late Completer<int> completer;

  Future<int> getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future<void> calculate() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    } catch (e) {
      result = 'An error occured: $e';
    }
  }

  void returnFG() {
    final futureGroup = FutureGroup<int>();

    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    final futures = Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);

    futureGroup.close();

    futureGroup.future.then((List<int> values) {
      int total = 0;
      for (int element in values) {
        total += element;
      }
      setState(() {
        result = total.toString();
      });
    });
  }

  Future returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }

  Future handleError() async {
    try {
      await returnError();
    }catch(error){
      setState((){
        result = error.toString();
      });
    }
    finally{
      print('Completed');
    }
  }

  String result = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back From The Future'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   child: const Text('GO!'),
            //   onPressed: () {
            //     setState(() {
            //       isLoading = true;
            //     });
            //     getData().then((value) {
            //       setState(() {
            //         result = value.body.toString().substring(0, 450);
            //         isLoading = false;
            //       });
            //     }).catchError((error) {
            //       setState(() {
            //         result = 'Error: $error';
            //         isLoading = false; // Selesai loading
            //       });
            //     });
            //   },
            // ),
            ElevatedButton(
                child: Text('GO!'),
                onPressed: () {
                  // getNumber().then((value) {
                  //   setState(() {
                  //     result = value.toString();
                  //   });
                  // }).catchError((e) {
                  //   result = 'An error occured: $e';
                  // });
                  // returnFG();
                  returnError().then((value) {
                    setState(() {
                      result = 'Success';
                    });
                  }).catchError((onError) {
                    setState(() {
                      result = 'Error: $onError';
                    });
                  }).whenComplete(() =>
                      print("Completed"));
                }),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  result,
                  textAlign: TextAlign.center,
                ),
              ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
