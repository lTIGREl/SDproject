import 'dart:math';

import 'package:SmartSolutions/Models/configuraciones.dart';
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
              "Menu de opciones",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Elige una",
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
              colors: [Configuraciones.colorA, Configuraciones.colorB],
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.0, 1.0))),
    );
    final caja = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        height: 330.0,
        width: 330.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Configuraciones.colorA, Configuraciones.colorB]),
            color: Colors.black,
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
          _crearBoton(
              context, Icons.text_fields, "Publicaciones", "navigation", null),
          _crearBoton(
              context, Icons.supervised_user_circle, "Perfil", "logout", null)
        ]),
        TableRow(children: [
          _crearBoton(
              context, Icons.assistant, "Populares", "navigation", "populares"),
          _crearBoton(context, Icons.file_upload, "Añadir post", "upload", null)
        ]),
        TableRow(children: [
          _crearBoton(
              context, Icons.edit, "Mis posts", "navigation", "misposts"),
          SizedBox()
        ])
      ],
    );
  }

  Widget _crearBoton(BuildContext context, IconData icono, String option,
      String ruta, String args) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ruta, arguments: args);
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
              backgroundColor: Configuraciones.colorB,
              radius: 30.0,
              child: Icon(
                icono,
                color: Configuraciones.colorA,
                size: 30.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(option, style: TextStyle(color: Configuraciones.colorB))
          ],
        ),
      ),
    );
  }
}
