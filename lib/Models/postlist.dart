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
    try {
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
    } catch (e) {}
    return null;
  }

  Future<List<Posts>> armarLista() async {
    List<Posts> postlist = [];
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child("Posts");
    try {
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
    } catch (e) {}
    return null;
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
    try {
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
    } catch (e) {}
    return null;
  }

  Future<List<Posts>> armarListaMisPosts() async {
    List<Posts> postlist = [];
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child("Posts");
    try {
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
    } catch (e) {}
    return null;
  }

  static Future<int> obtenerLikes(String idref) async {
    int likesG;
    DatabaseReference postRef = FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .child(idref)
        .child("likes");
    await postRef.once().then((DataSnapshot snap) {
      var likes = snap.value;
      likesG = likes;
    });
    return likesG;
  }

  static Future<bool> userLiked(String idref) async {
    bool bul = false;
    DatabaseReference postRef = FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .child(idref)
        .child("userLiked");
    try {
      await postRef.once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        for (var postkey in keys) {
          if (data[postkey]['username'] == Usuario.user.displayName) {
            bul = true;
          }
        }
      });
    } catch (e) {
      return null;
    }
    return bul;
  }

  static removePost(String idref) {
    FirebaseDatabase.instance.reference().child("Posts").child(idref).remove();
  }
}
