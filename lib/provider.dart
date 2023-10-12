import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/model/notemodel.dart';

class HomeController with ChangeNotifier {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  NoteModel? _selectedNote;
  NoteModel? get selectedNote => _selectedNote;
  List<String> _selectedNotes = [];
  List<String> get selectedNotes => _selectedNotes;
  List<NoteModel>? _notes;
  List<NoteModel>? get notes => _notes;
  bool isNoteSelected = false;

  setSelectedNote() {
    for (NoteModel note in notes!) {
      if (note.id == selectedNotes[0]) {
        _selectedNote = note;
      }
    }
    notifyListeners();
  }

  _setNote() {
    return NoteModel(
      title: title.text.trim(),
      content: content.text.trim(),
      datetime:DateTime.now(),
    );
  }

  setSelectedNotes(String value) {
    _selectedNotes.add(value);
    notifyListeners();
  }

  removeSelectedNotes(String value) {
    _selectedNotes.remove(value);
    notifyListeners();
  }

  addNotes() async {
    NoteModel note = _setNote();
    final docid = await db.collection('notes').add(note.toMap());
    note.id = docid.id;
    await db.collection('notes').doc(docid.id).update(note.toMap());
    await getNotes();
    notifyListeners();
  }

  getNotes() async {
    final notesCollection = await db.collection('notes').get();
    final notesList =
        notesCollection.docs.map((e) => NoteModel.fromSnaphot(e)).toList();
    _notes = notesList;
    notifyListeners();
  }

  delete() {
    log('delete pressed');
   
    for (var i = 0; i < selectedNotes.length; i++) {
      db.collection('notes').doc(selectedNotes[i]).delete();
    }
    selectedNotes.clear();
    isNoteSelected = false;

    getNotes();
    notifyListeners();
  }

  clearSelectedNotes() {
    _selectedNotes.clear();
    notifyListeners();
  }

  void selectNote() {
    isNoteSelected = !isNoteSelected;

    notifyListeners();
  }

  allNotes() {
    if (selectedNotes.length == notes!.length) {
      clearSelectedNotes();
    } else {
      _selectedNotes = notes!.map((e) => e.id!).toList();
    }
    notifyListeners();
  }

  updateNote() async {
    log(title.text.trim());
    selectedNote!.title=title.text.trim();
    selectedNote!.content=content.text.trim();
    selectedNote!.datetime=DateTime.now();
    await db.collection('notes').doc(selectedNote!.id).set(selectedNote!.toMap());
    getNotes();
    notifyListeners();
  }
}
