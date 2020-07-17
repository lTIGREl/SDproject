import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final titlestyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final subtitlestyle = TextStyle(fontSize: 18.0, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image(
              image: NetworkImage(
                  'https://www.tom-archer.com/wp-content/uploads/2018/06/milford-sound-night-fine-art-photography-new-zealand.jpg')),
          _crearDatos(),
          _crearAcciones(),
          _crearDescripcion(),
          _crearDescripcion(),
          _crearDescripcion(),
          _crearDescripcion(),
          _crearDescripcion(),
          _crearDescripcion()
        ],
      ),
    ));
  }

  Widget _crearDatos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Title about the problem',
                    style: titlestyle,
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    'Problem publication´s date',
                    style: subtitlestyle,
                  )
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red,
            ),
            Text(
              '42',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _columnaBotones(Icons.call, 'Call'),
        _columnaBotones(Icons.insert_comment, 'Comment'),
        _columnaBotones(Icons.plus_one, 'Like'),
      ],
    );
  }

  Widget _columnaBotones(IconData icon, String detail) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.blue,
        ),
        SizedBox(
          height: 7.0,
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }

  Widget _crearDescripcion() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Text(
          'aqui va la descripcion del problema que se está presentando en la pestaña, efectivamente debe ser un texto amplio para poder visualizarlo.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
