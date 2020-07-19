import 'package:SmartSolutions/Models/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final titlestyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  final subtitlestyle = TextStyle(fontSize: 18.0, color: Colors.grey);
  int likesG;

  @override
  Widget build(BuildContext context) {
    final Posts post = ModalRoute.of(context).settings.arguments;
    likesG = post.likes;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(image: NetworkImage(post.image)),
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
            context, Icons.location_on, 'Location', lat, long, 'map', '', 0),
        _columnaBotones(
            context, Icons.insert_comment, 'Comment', lat, long, 'map', '', 0),
        _columnaBotones(
            context, Icons.plus_one, 'Like', lat, long, 'like', idref, likes)
      ],
    );
  }

  Widget _columnaBotones(BuildContext context, IconData icon, String detail,
      String lat, String long, String dir, String idref, int likes) {
    return GestureDetector(
      onTap: () {
        if (dir == 'map') {
          Navigator.pushNamed(context, dir, arguments: [lat, long]);
        } else {
          if (dir == 'like') {
            FirebaseDatabase.instance
                .reference()
                .child("Posts")
                .child(idref)
                .update({"likes": likes + 1});
            likesG += 1;
          }
        }
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
