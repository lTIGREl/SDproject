import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:SmartSolutions/Pages/homepage.dart';
import 'package:SmartSolutions/Models/usuario.dart';

class PhotoUpload extends StatefulWidget {
  PhotoUpload();
  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File sampleImage;
  final formKey = GlobalKey<FormState>();
  String _description;
  String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request editor"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: sampleImage == null
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Select an image related to your problem"),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text("Give us a description about your problem"),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text("Upload your post"),
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
        onPressed: getImage,
        tooltip: "Add image",
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
                Image.file(
                  sampleImage,
                  height: 300.0,
                  width: 600.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) {
                    return value.isEmpty ? "Required description" : null;
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
                  textColor: Colors.white,
                  color: Colors.lightBlueAccent,
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
      print(url);
      //guardar el post en firebase database: realtime
      saveToDatabase(url);
      //regreso a home
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
  }

  void saveToDatabase(String url) {
    var timeDB = DateTime.now();
    var dateFormat = DateFormat('MMM d, yyyy');
    var timeFormat = DateFormat('EEEE, hh:mm aaa');
    String date = dateFormat.format(timeDB);
    String time = timeFormat.format(timeDB);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "description": _description,
      "date": date,
      "time": time,
      "photo": Usuario.user.photoUrl,
      "username": Usuario.user.displayName
    };
    ref.child("Posts").push().set(data);
  }
}
