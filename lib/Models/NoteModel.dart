import 'package:flutter/cupertino.dart';

class Note{
  int id;
  String note;
  String image;
  String date;
//  Note( {this.id,this.note, this.image,this.date});

  Note(this.id, this.note, this.image, this.date);

  Note.withId(this.id,this.note, this.image,this.date);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
      'image':image,
      'date':date
    };
  }




  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.note= map['note'];
    this.image = map['image'];
    this.date=map['date'];
  }



}