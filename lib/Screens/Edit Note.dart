import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/Models/NoteModel.dart';
import 'package:note_app/Utils/Database_helper.dart';
import 'package:note_app/Utils/Utility.dart';
class EditNote extends StatefulWidget {
  Note note;

  EditNote(this.note);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EidtState();
  }


}
class EidtState extends State<EditNote>{
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController EditNoteController = new TextEditingController();
  String imgString;
  @override
  void initState() {
    super.initState();
    EditNoteController = new TextEditingController(text: widget.note.note );

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton(
              onPressed: btnEdit,
              child: Text(
                'Edit',
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
                      controller: EditNoteController,
                      maxLines: null,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      )),
                ),
                new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.note.image == null
                      ? Text('')
                      : Image.memory(Utility.dataFromBase64String(widget.note.image),

                  )),
              ],
            ),
          )),
    ) ;
  }
  void btnEdit(){

    Note noteee=new Note(widget.note.id, EditNoteController.text, widget.note.image, widget.note.date);
     databaseHelper.updateNote(noteee);
  //  updateListView();
    Navigator.pushReplacementNamed(context, "/HomeScreen");
  }

}