import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';
import 'dart:math';
import 'numberStream.dart';
import 'random_screen.dart';

void main() {
  runApp(const MyApp());
}

class NumberStream{
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t){
      Random random = Random();
      int myNum = random.nextInt(10);
      return myNum;
    });
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rafsan Alhad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RandomScreen(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  // int lastNumber = 0;
  // late StreamController numberStreamController;
  // late NumberStream numberStream;
  late Stream<int> numberStream;
  // Color bgColor = Colors.blueGrey;
  // late ColorStream colorStream;
  // late StreamTransformer<int, int>
  //     transformer; // 
  // late StreamSubscription subscription;
  // late StreamSubscription subscription2;

  // String values = '';

  @override
  // void dispose(){
  //   _bloc.dispose();
  //   super.dispose();
  // }
  // void dispose() {
  //   numberStreamController.close();
  //   subscription.cancel();
  //   super.dispose();
  // }

  // void addRandomNumber() {
  //   Random random = Random();
  //   int myNum = random.nextInt(10);
  //   if(!numberStreamController.isClosed){
  //     numberStream.addNumberToSink(myNum);
  //   }else{
  //     setState((){
  //       lastNumber = -1;
  //     });
  //   }
  // }

  // void stopStream(){
  //   numberStreamController.close();
  // }

  // void initState() {
  //   numberStream = NumberStream();
  //   numberStreamController = numberStream.controller;

  //   Stream stream = numberStreamController.stream.asBroadcastStream();

  //   subscription = stream.listen((event){
  //     setState((){
  //         values += '$event - ';
  //     });
  //   });
  //   subscription2 = stream.listen((event){
  //     setState((){
  //       values += '$event - ';
  //     });
  //   });
  //   subscription.onError((error){
  //     setState((){
  //       lastNumber = -1;
  //     });
  //   });

  //   subscription.onDone((){
  //     print('OnDone was called');
  //   });
  //   super.initState();
  // }

  // void changeColor() async {
  //   await for (Color eventColor in colorStream.colorStream) {
  //     setState(() {
  //       bgColor = eventColor;
  //     });
  //   }

  //   // colorStream.getColors().listen((eventColor)){
  //   //   setState(() {
  //   //     bgColor = eventColor;
  //   //   })
  //   // }
  // }

  @override
  void initState(){
    numberStream = NumberStream().getNumbers();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rafsan Alhad'),
        ),
        // body: SizedBox(
        //     width: double.infinity,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(values),
        //         ElevatedButton(
        //           onPressed: () => addRandomNumber(),
        //           child: const Text('New Random Number'),
        //         ),
        //         ElevatedButton(
        //           onPressed: () => stopStream(),
        //           child: const Text('Stop Subscription'),
        //         ),
                
        //       ],
        //     ))
        body: StreamBuilder(
          stream: numberStream,
          initialData: 0,
          builder: (context, snapshot){
            if(snapshot.hasError){
              print('Error!');
            }
            if(snapshot.hasData){
              return Center(child: Text(snapshot.data.toString(), style: const TextStyle(fontSize: 96),));
            }else{
              return const SizedBox.shrink();
            }
          }
        )
            
            );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
