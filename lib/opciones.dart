import 'dart:math';

import 'package:flutter/material.dart';

class OptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondo(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_titulos(), _botonesOpciones(context)],
            ),
          )
        ],
      ),
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Settings",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Select one",
                style: TextStyle(color: Colors.white, fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  Widget _fondo() {
    final gradient = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.purple],
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.0, 1.0))),
    );
    final caja = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        height: 330.0,
        width: 330.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.white]),
            color: Colors.pink,
            borderRadius: BorderRadius.circular(80.0)),
      ),
    );
    return Stack(
      children: <Widget>[
        gradient,
        Positioned(
          child: caja,
          top: -70,
        )
      ],
    );
  }

  Widget _botonesOpciones(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBoton(context, Icons.navigation, "Navigate", "navigation"),
          _crearBoton(
              context, Icons.supervised_user_circle, "Profile", "logout")
        ]),
        TableRow(children: [
          _crearBoton(context, Icons.edit, "Edit posts", "navigation"),
          _crearBoton(context, Icons.file_upload, "Add post", "upload")
        ])
      ],
    );
  }

  Widget _crearBoton(
      BuildContext context, IconData icono, String option, String ruta) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
      child: Container(
        padding: EdgeInsets.all(30),
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              radius: 30.0,
              child: Icon(
                icono,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(option, style: TextStyle(color: Colors.pinkAccent))
          ],
        ),
      ),
    );
  }
}
