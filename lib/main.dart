import 'package:SmartSolutions/homepage.dart';
import 'package:SmartSolutions/logoutpage.dart';
import 'package:SmartSolutions/mainpage.dart';
import 'package:SmartSolutions/mapapage.dart';
import 'package:SmartSolutions/opciones.dart';
import 'package:SmartSolutions/photoupload.dart';
import 'package:SmartSolutions/postPage.dart';
import 'package:flutter/material.dart';
import 'package:SmartSolutions/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      initialRoute: 'main',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'post': (BuildContext context) => PostPage(),
        'main': (BuildContext context) => MainPage(),
        'options': (BuildContext context) => OptionPage(),
        'navigation': (BuildContext context) => HomePage(),
        'logout': (BuildContext context) => LogoutPage(),
        'upload': (BuildContext context) => PhotoUpload(),
        'map': (BuildContext context) => MapPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
