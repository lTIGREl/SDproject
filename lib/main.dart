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
      initialRoute: 'post',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'post': (BuildContext context) => PostPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
