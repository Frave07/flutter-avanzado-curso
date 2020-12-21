import 'package:band_names/src/Pages/Status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names/src/Pages/Home.dart';
import 'package:band_names/src/Services/Socket.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MultiProvider(
        providers: [
            ChangeNotifierProvider(create: (_) => SocketServices() )
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Band Names',
        home: HomePage()
      ),
    );
  }
}