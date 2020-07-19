import 'package:SmartSolutions/Models/post.dart';
import 'package:firebase_database/firebase_database.dart';

class ListPosts {
  Future<List<Posts>> armarLista() async {
    List<Posts> postlist = [];
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child("Posts");
    await postRef.once().then((DataSnapshot snap) {
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
            data[postKey]['username'],
            data[postKey]['lat'],
            data[postKey]['long'],
            data[postKey]['title'],
            data[postKey]['likes'],
            data[postKey]['idref']);
        postlist.add(post);
      }
    });
    return postlist;
  }
}
