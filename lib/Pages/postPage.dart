import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final titlestyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final subtitlestyle = TextStyle(fontSize: 18.0, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    final List<String> args = ModalRoute.of(context).settings.arguments;
    final image = args[0];
    final description = args[1];
    final date = args[2];
    final time = args[3];
    final photo = args[4];
    final username = args[5];
    final lat = args[7];
    final long = args[8];
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image(image: NetworkImage(image)),
          _crearDatos(),
          _crearAcciones(context, lat, long),
          _crearDescripcion(description),
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

  Widget _crearAcciones(BuildContext context, String lat, String long) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _columnaBotones(
            context, Icons.location_on, 'Location', lat, long, 'map'),
        _columnaBotones(
            context, Icons.insert_comment, 'Comment', lat, long, 'map'),
        _columnaBotones(context, Icons.plus_one, 'Like', lat, long, 'map'),
      ],
    );
  }

  Widget _columnaBotones(BuildContext context, IconData icon, String detail,
      String lat, String long, String dir) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, dir, arguments: [lat, long]);
      },
      child: Column(
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
      ),
    );
  }

  Widget _crearDescripcion(String description) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Text(
          description,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
