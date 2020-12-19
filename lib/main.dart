import 'package:flutter/material.dart';

import 'package:band_names/src/Pages/Home.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Band Names',
      home: HomePage()
    );
  }
}