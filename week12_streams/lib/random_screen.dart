import 'package:flutter/material.dart';
import 'package:week12_streams/random_bloc.dart';
import 'random_bloc.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  final _bloc = RandomNumberBloc();

  @override
  void dispose() {
    _bloc.dispose(); // Pastikan stream ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number Generator'),
      ),
      body: StreamBuilder<int>(
        stream: _bloc.randomNumber,
        initialData: 0,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error occurred!'));
          }
          if (snapshot.hasData) {
            return Text(
              'Random Number: ${snapshot.data}', style: const TextStyle(fontSize: 24),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.generateRandom.add(null);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
