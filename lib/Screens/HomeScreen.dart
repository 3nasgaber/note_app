import 'package:flutter/material.dart';
import 'package:note_app/Models/NoteModel.dart';
import 'package:note_app/Screens/AddNote.dart';
import 'package:note_app/Screens/Edit%20Note.dart';
import 'package:note_app/Utils/Constants.dart';
import 'package:note_app/Utils/Database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'NoteCard.dart';

class HomeSreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homescreen();
  }
}

class _homescreen extends State<HomeSreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count =0;
  Note selectedNote;
   static String choicevalue='Listview';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
           onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        title: Text('Notes'),
      ),
      body: _listview(),
      //choicevalue=='Listview'?_listview():_gradview(),
      floatingActionButton: FloatingActionButton(
        onPressed: _btnAction,
        tooltip: 'ADD Note',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.);
    );
  }
  void choiceAction(String choice) {
    setState(() {
      if (choice == 'Listview') {
        choicevalue=choice;
        print(choicevalue);
      } else if (choice == 'Gradview') {
        choicevalue=choice;
        print(choicevalue);
      }
    });

  }
  Widget _gradview() {
    if (noteList?.isEmpty ?? true) {
      return Center(child: Text('Empty gradview'));
    } else {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: noteList.length,
          itemBuilder: (context, index) {
            return Container(
                child: new Column(
                  children: <Widget>[
                    new Card(
                      child: new Container(
                        margin: new EdgeInsets.all(20.0),
                        width: double.infinity,
                        child: new Row(
                          children: <Widget>[
                            new Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  noteList[index].note,
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),

                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          });
    }

  }
  Widget _listview() {

    if (noteList?.isEmpty ?? true) {
      return Center(child: Text('Empty listview'));
    } else {
      return new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: List.generate(count, (index) {
            //selectedNote=noteList[index];
            return Center(
              child: NoteCard(note: noteList[index], item: noteList[index],onLongPress: () =>itemLongPress(noteList[index]), ),
            );


          }
          ),

      );
    }
  }
  void _btnAction() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNote(),
        ));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList.reversed.toList();
          this.count = noteList.length;
        });
      });
    });
  }

 itemLongPress(Note note) {
   showModalBottomSheet<void>(context: context,
   builder: (BuildContext context) {
       return new Column(
         mainAxisSize: MainAxisSize.min,
         children: <Widget>[
         new ListTile(
           leading: new Icon(Icons.delete),
           title: new Text('Delete'),
         onTap:(){
           Navigator.pop(context);
           _delete(note.id);
         },
         ),
         new ListTile(
           leading: new Icon(Icons.edit),
           title: new Text('Edit'),
          onTap: (){
            Navigator.pop(context);
            _editNote(note);
          },
         ),
       ],

       );


   });
 }


   _delete( int id) async {
     await databaseHelper.deleteNote(id);
     updateListView();
  }


   _editNote(Note note) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNote(note),
        ));
  }
}



