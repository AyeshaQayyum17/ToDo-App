import 'dart:async';
import 'package:flutter/material.dart';
import 'ToDoScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});


  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ToDoscreen(),
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Center(child: Text('Splash Screen')),
      ),
      body: Center(
        child: Text('Welcome to the our Task 1 \n'
            'In this we Created ToDo App\n'
            'We created Database in firebase to storage the data',
        style: TextStyle(
          fontSize: 30
        ),),
      ),
    );
  }
}