import 'package:SmartSolutions/Models/configuraciones.dart';
import 'package:SmartSolutions/Models/obtainlocation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:SmartSolutions/Models/usuario.dart';

class PhotoUpload extends StatefulWidget {
  PhotoUpload();
  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File sampleImage;
  final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Configuraciones.colorA, Configuraciones.colorB],
          ),
        ),
        child: Center(
          child: sampleImage == null
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Elige una portada para tu publicación"),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text("Danos una descripción sobre tu problema"),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text("Sube tu publicación"),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              : enableUpload(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Configuraciones.colorA,
        onPressed: getImage,
        tooltip: "Añadir imagen",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  Widget enableUpload() {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Título"),
                  validator: (val) {
                    return val.isEmpty ? 'Título requerido' : null;
                  },
                  onSaved: (val) {
                    return _title = val;
                  },
                ),
                Image.file(
                  sampleImage,
                  height: 300.0,
                  width: 600.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Descripción"),
                  validator: (value) {
                    return value.isEmpty ? "Descripción requerida" : null;
                  },
                  onSaved: (value) {
                    return _description = value;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                RaisedButton(
                  elevation: 10.0,
                  child: Text("Añadir post"),
                  textColor: Configuraciones.colorB,
                  color: Configuraciones.colorA,
                  onPressed: subirImagen,
                )
              ],
            ),
          ),
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

  void subirImagen() async {
    //subir imagen firebase storage
    if (validarYguardar()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Post Images");
      final time = DateTime.now();
      final StorageUploadTask uploadTask =
          postImageRef.child(time.toString() + "jpg").putFile(sampleImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      //guardar el post en firebase database: realtime
      obtainLocation().whenComplete(() async {
        List loc = await obtainLocation();
        saveToDatabase(url, loc);
        //regreso a home
        Navigator.pop(context);
      });
    }
  }

  void saveToDatabase(String url, List loc) {
    var timeDB = DateTime.now();
    var dateFormat = DateFormat('MMM d, yyyy');
    var timeFormat = DateFormat('EEEE, hh:mm aaa');
    String date = dateFormat.format(timeDB);
    String time = timeFormat.format(timeDB);
    String lat = loc[0];
    String long = loc[1];

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var idref = ref.child("Posts").push();
    var data = {
      "image": url,
      "description": _description,
      "date": date,
      "time": time,
      "photo": Usuario.user.photoUrl,
      "username": Usuario.user.displayName,
      "lat": lat,
      "long": long,
      'title': _title,
      'likes': 0,
      'idref': idref.key
    };
    idref.set(data);
  }
}
