import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter RESAS App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('市区町村一覧'),
        )
        ,
        body: const Center(
          child: Text('市区町村の一覧画面です'),
        ),
      ),
    );
  }
}