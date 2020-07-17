import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:SmartSolutions/Models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> postlist = [];
//coment
  @override
  void initState() {
    super.initState();
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      postlist.clear();

      for (var postKey in keys) {
        Posts post = Posts(
            data[postKey]['image'],
            data[postKey]['description'],
            data[postKey]['date'],
            data[postKey]['time'],
            data[postKey]['photo'],
            data[postKey]['username']);
        postlist.add(post);
      }
      setState(() {});
    });
  }

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
        child: postlist.length == 0
            ? Text("No data found")
            : ListView.builder(
                itemCount: postlist.length,
                itemBuilder: (_, index) {
                  return postUI(
                      postlist[index].image,
                      postlist[index].description,
                      postlist[index].date,
                      postlist[index].time,
                      postlist[index].photo,
                      postlist[index].username);
                },
              ),
      ), //posts
    );
  }

  Widget postUI(String image, String description, String date, String time,
      String photo, String username) {
    return Card(
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
                  date,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  username,
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
                  time,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Image.network(
                  photo,
                  width: 50.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Image.network(image, fit: BoxFit.cover),
            SizedBox(
              height: 10.0,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
