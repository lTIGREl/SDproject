import 'package:SmartSolutions/Pages/loginpage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.white, Colors.black],
        ),
      ),
      child: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(),
          _pagina2(),
        ],
      ),
    ));
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _imagenFondo(),
        _presentacion(),
      ],
    );
  }

  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(image: AssetImage('assets/foco.png')),
    );
  }

  Widget _presentacion() {
    final estiloTexto = TextStyle(color: Colors.black, fontSize: 50.0);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Bienvenidos a',
            style: estiloTexto,
          ),
          Text(
            'Smart Solutions',
            style: estiloTexto,
          ),
          Expanded(child: Container()),
          Icon(
            Icons.keyboard_arrow_up,
            size: 70.0,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _pagina2() {
    return LoginPage();
  }
}
