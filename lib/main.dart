import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatefulWidget{
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  Widget  build(BuildContext context){
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
    );
  }
}