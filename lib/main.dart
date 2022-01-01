import 'package:flutter/material.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Working has just started'),
        ),
        body: const Center(
          child: Text('Welcome'),
        ),
      ),
    );
  }
}
