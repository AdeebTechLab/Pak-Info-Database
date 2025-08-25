
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pak_info/splashScreen.dart';

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Splashscreen(),
      ),
    );
  }
}
