import 'package:SmartSolutions/Models/configuraciones.dart';
import 'package:SmartSolutions/Models/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var colorBoton = Configuraciones.colorA;
  final titlestyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  final subtitlestyle = TextStyle(fontSize: 18.0, color: Colors.black);
  int likesG;

  @override
  Widget build(BuildContext context) {
    final Posts post = ModalRoute.of(context).settings.arguments;
    likesG = post.likes;
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Configuraciones.colorA, Configuraciones.colorB],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Image(image: NetworkImage(post.image)),
                onTap: () {
                  Navigator.pushNamed(context, 'photo', arguments: post.image);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    post.username,
                    style: titlestyle,
                  ),
                  Image.network(post.photo, width: 50.0),
                ],
              ),
              _crearDatos(post.title, post.date, post.time, likesG),
              _crearAcciones(context, post.lat, post.long, post.idref, likesG),
              _crearDescripcion(post.description),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _crearDatos(String title, String date, String time, int likes) {
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
                    title,
                    style: titlestyle,
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    date + ' ' + time,
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
              likes.toString(),
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones(
      BuildContext context, String lat, String long, String idref, int likes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _columnaBotones(
            context, Icons.location_on, 'Location', lat, long, 'map'),
        _columnaBotones(
            context, Icons.insert_comment, 'Comment', lat, long, 'comments'),
        _botonLike(context, Icons.plus_one, 'Like', 'like', idref, likes)
      ],
    );
  }

  Widget _columnaBotones(BuildContext context, IconData icon, String detail,
      String lat, String long, String dir) {
    return GestureDetector(
      onTap: () {
        if (dir == 'map') {
          Navigator.pushNamed(context, dir, arguments: [lat, long]);
        }
        if (dir == 'comments') {
          Navigator.pushNamed(context, dir);
        }
      },
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: colorBoton,
          ),
          SizedBox(
            height: 7.0,
          ),
          Text(
            detail,
            style: TextStyle(fontSize: 15.0, color: colorBoton),
          )
        ],
      ),
    );
  }

  Widget _botonLike(BuildContext context, IconData icon, String detail,
      String dir, String idref, int likes) {
    return GestureDetector(
      onTap: () {
        FirebaseDatabase.instance
            .reference()
            .child("Posts")
            .child(idref)
            .update({"likes": likes + 1});
        likesG += 1;
      },
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: colorBoton,
          ),
          SizedBox(
            height: 7.0,
          ),
          Text(
            detail,
            style: TextStyle(fontSize: 15.0, color: colorBoton),
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
