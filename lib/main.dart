import 'package:SmartSolutions/Pages/homepage.dart';
import 'package:SmartSolutions/Pages/logoutpage.dart';
import 'package:SmartSolutions/Pages/mainpage.dart';
import 'package:SmartSolutions/Pages/mapapage.dart';
import 'package:SmartSolutions/Pages/opciones.dart';
import 'package:SmartSolutions/Pages/photoupload.dart';
import 'package:SmartSolutions/Pages/postPage.dart';
import 'package:flutter/material.dart';
import 'package:SmartSolutions/Pages/loginpage.dart';

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
