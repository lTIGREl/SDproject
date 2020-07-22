import 'package:SmartSolutions/Models/configuraciones.dart';
import 'package:SmartSolutions/Models/postlist.dart';
import 'package:flutter/material.dart';
import 'package:SmartSolutions/Models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String opcion;
  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context).settings.arguments;
    opcion = args;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Configuraciones.colorA, Configuraciones.colorB],
          ),
        ),
        child: FutureBuilder(
            future: opcion == "populares"
                ? ListPosts().armarListaPopulares()
                : opcion == "misposts"
                    ? ListPosts().armarListaMisPosts()
                    : ListPosts().armarLista(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
              if (snapshot.hasData) {
                return (ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return postUI(snapshot.data[index]);
                  },
                ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ), //posts
    );
  }

  Widget postUI(Posts post) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'post', arguments: post);
      },
      child: Card(
        color: Colors.white70,
        elevation: 10.0,
        margin: EdgeInsets.all(14.0),
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    post.date,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    post.username,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    post.time,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  Image.network(
                    post.photo,
                    width: 50.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Image.network(post.image, fit: BoxFit.cover),
              SizedBox(
                height: 10.0,
              ),
              Text(
                post.title,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
