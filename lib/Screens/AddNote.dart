import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:note_app/Models/NoteModel.dart';
import 'package:note_app/Utils/Database_helper.dart';
import 'package:note_app/Utils/Utility.dart';

class AddNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addnote();
  }
}

class _addnote extends State<AddNote> {
  File _image;
  String imgString;
  static int _id = 0;
  TextEditingController writeNoteController = new TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.art_track,
                color: Colors.white,
              ),
              onPressed: () {
                getImage();
              },
            ),
            FlatButton(
                onPressed: btnAddNote,
                child: Text(
                  'Done',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0),
                )),
          ],
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
            child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.all(15.0),
                child: TextField(
                    controller: writeNoteController,
                    maxLines: null,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Write your note here',
                      border: InputBorder.none,
                    )),
              ),
              new Container(
                padding: const EdgeInsets.all(8.0),
                child: _image == null
                    ? Text('')
                    : Image.file(
                        _image,
                        width: 300,
                        height: 300,
                      ),
              ),
            ],
          ),
        )));
  }

  void btnAddNote() {
    String noteText = writeNoteController.text;
    Note note = new Note(_id = _id + 1, noteText, imgString, getDate());
    databaseHelper.insertNote(note);
    Navigator.pushReplacementNamed(context, "/HomeScreen");
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat.yMMMMd("en_US");
    String formatted = formatter.format(now);
    print(formatted); // something like 2013-04-20
    return formatted;
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    imgString = Utility.base64String(_image.readAsBytesSync());
  }
}
