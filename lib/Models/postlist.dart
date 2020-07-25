import 'package:SmartSolutions/Models/comentarios.dart';
import 'package:SmartSolutions/Models/post.dart';
import 'package:SmartSolutions/Models/usuario.dart';
import 'package:firebase_database/firebase_database.dart';

class ListPosts {
  Future<List<Comments>> comentarios(String id) async {
    List<Comments> comentlist = [];
    DatabaseReference postRef = FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .child(id)
        .child("comments");
    await postRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      comentlist.clear();
      for (var postKey in keys) {
        Comments comment = Comments(
          data[postKey]['description'],
          data[postKey]['photo'],
          data[postKey]['username'],
        );
        comentlist.add(comment);
      }
    });
    return comentlist;
  }

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

  List<Posts> orden(List<Posts> postslist) {
    List<Posts> posts = postslist;
    for (int x = 0; x < posts.length; x++) {
      for (int i = 0; i < posts.length - x - 1; i++) {
        if (posts[i].likes < posts[i + 1].likes) {
          Posts tmp = posts[i + 1];
          posts[i + 1] = posts[i];
          posts[i] = tmp;
        }
      }
    }
    return posts;
  }

  List<Posts> myposts(List<Posts> postslist) {
    List<Posts> posts = [];
    for (int x = 0; x < postslist.length; x++) {
      if (postslist[x].username == Usuario.user.displayName) {
        posts.add(postslist[x]);
      }
    }
    return posts;
  }

  Future<List<Posts>> armarListaPopulares() async {
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
    postlist = orden(postlist);
    return postlist;
  }

  Future<List<Posts>> armarListaMisPosts() async {
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
    postlist = myposts(postlist);
    return postlist;
  }
}
