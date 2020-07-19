import 'package:SmartSolutions/Models/postlist.dart';
import 'package:flutter/material.dart';
import 'package:SmartSolutions/Models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Solutions"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: FutureBuilder(
            future: ListPosts().armarLista(),
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
