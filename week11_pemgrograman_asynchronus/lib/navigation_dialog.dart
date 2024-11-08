import 'package:flutter/material.dart';

class NavigationDialog extends StatefulWidget {
  const NavigationDialog({super.key});

  @override
  State<NavigationDialog> createState() => _NavigationDialogState();
}

class _NavigationDialogState extends State<NavigationDialog> {
  Color color = Colors.blue.shade700;
  _showColorDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_){
        return AlertDialog(
          title: const Text('Very important question'),
          content: const Text('Please choose a color'),
          actions: <Widget>[
            TextButton(child: const Text('Red'),
            onPressed: (){
              color = Colors.red.shade700;
              Navigator.pop(context, color);
            }),
             TextButton(child: const Text('Green'),
            onPressed: (){
              color = Colors.green.shade700;
              Navigator.pop(context, color);
            }),
             TextButton(child: const Text('Purple'),
            onPressed: (){
              color = Colors.purple.shade700;
              Navigator.pop(context, color);
            }),
          ]
        );
      }
    );
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color,
        appBar: AppBar(
          title: const Text('Navigation Dialog Screen'),
        ),
        body: Center(
          child: ElevatedButton(
              child: const Text('Change Color'), onPressed: () {_showColorDialog(context);}),
        ));
  }
}
