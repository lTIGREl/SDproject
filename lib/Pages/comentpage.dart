import 'package:SmartSolutions/Models/comentarios.dart';
import 'package:SmartSolutions/Models/configuraciones.dart';
import 'package:SmartSolutions/Models/postlist.dart';
import 'package:SmartSolutions/Models/usuario.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ComentPage extends StatefulWidget {
  @override
  _ComentPageState createState() => _ComentPageState();
}

class _ComentPageState extends State<ComentPage> {
  String _comment;
  String _id;
  final formKey = GlobalKey<FormState>();
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    _id = id;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: ListPosts().comentarios(_id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Comments>> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              return _postComment(snapshot.data[index]);
                            }),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(labelText: "Comentario"),
                        validator: (val) {
                          return val.isEmpty ? 'Comentario requerido' : null;
                        },
                        onSaved: (val) {
                          return _comment = val;
                        },
                      ),
                    ),
                    RaisedButton(
                      elevation: 10.0,
                      child: Text("Comentar"),
                      textColor: Configuraciones.colorB,
                      color: Configuraciones.colorA,
                      onPressed: () {
                        subirComentario();
                        setState(() {
                          _controller.clear();
                        });
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  bool validarYguardar() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void subirComentario() async {
    if (validarYguardar()) {
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var idref = ref.child("Posts").child(_id).child("comments").push();
      var data = {
        "description": _comment,
        "photo": Usuario.user.photoUrl,
        "username": Usuario.user.displayName,
      };
      idref.set(data);
    }
  }

  Widget _postComment(Comments comment) {
    return Card(
        color: Colors.white70,
        elevation: 10.0,
        margin: EdgeInsets.all(14.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    comment.photo,
                    height: 30,
                  ),
                  SizedBox(width: 20),
                  Text(comment.username),
                ],
              ),
              Text(comment.comment)
            ],
          ),
        ));
  }
}
