import 'package:flutter/material.dart';
import 'package:note_app/Models/NoteModel.dart';
import 'package:note_app/Utils/Utility.dart';
class NoteCard extends StatelessWidget {
  const NoteCard(
      {Key key, this.note, this.onLongPress, @required this.item, this.selected: false}
      ) : super(key: key);

  final Note note;
  final VoidCallback onLongPress;
  final Note item;
  final bool selected;


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return InkWell(
      onLongPress: onLongPress,

     child:Container(
       width: double.infinity,
       child: new  Card(
           color: Colors.white,
           child: Column(
             children: <Widget>[
               new Container(
                   padding: const EdgeInsets.all(8.0),
                   child: note.image==null? Text('')
                       :Utility.imageFromBase64String(note.image)
               ),
               new Container(
                 padding: const EdgeInsets.all(10.0),
                 child:
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(note.date, style: TextStyle(color: Colors.black.withOpacity(0.5))),
                     Text(note.note),
                   ],
                 ),

               )
             ],
             crossAxisAlignment: CrossAxisAlignment.start,
           )
       ),
     )

    );
  }
}
