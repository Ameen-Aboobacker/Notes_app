import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? id;
  String? title;
  String? content;
  DateTime? datetime;
  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.datetime,
  });
  toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': datetime,
    };
  }

  factory NoteModel.fromSnaphot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data()!;
    Timestamp timestamp = data['date']; 
    return NoteModel(
        id: data['id'],
        title: data['title'],
        content: data['content'],
        datetime: timestamp.toDate(),);
  }
}
