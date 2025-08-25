
import 'package:atlab/Driving%20License.dart';
import 'package:atlab/Electricity.dart';
import 'package:atlab/FBR.dart';
import 'package:atlab/HomePage.dart';
import 'package:atlab/OnlineFir.dart';
import 'package:atlab/Passport.dart';
import 'package:atlab/Ptcl.dart';
import 'package:atlab/SUIGAS.dart';
import 'package:atlab/SimDataPage.dart';
import 'package:atlab/TrackingParsel.dart';
import 'package:atlab/VehicleVerification.dart';
import 'package:atlab/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
