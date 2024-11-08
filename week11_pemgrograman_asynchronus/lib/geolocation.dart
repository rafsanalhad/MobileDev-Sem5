import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  
  @override
  void initState() {
    super.initState();
    getPosition().then((Position myPos) { 
      setState(() {
        myPosition = 'Latitude: ${myPos.latitude}, Longitude: ${myPos.longitude}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final myWidget = myPosition == '' ? const CircularProgressIndicator() : Text(myPosition);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location : Muhammad Harafsan Alhad')
      ),
      body: Center(
        child: Text(myPosition)
      )
    );
  }
}

Future<Position> getPosition() async { 
  await Geolocator.requestPermission();
  await Geolocator.isLocationServiceEnabled();
  Position position = await Geolocator.getCurrentPosition();
  return position;
}