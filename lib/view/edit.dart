import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../model/notemodel.dart';
import '../provider.dart';

class Edit extends StatelessWidget {
  const Edit({Key? key,  this.isEdit=true}) : super(key: key);
final bool isEdit;
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<HomeController>(context, listen: false);
    final NoteModel? selectedNote = notesProvider.selectedNote;
    final title =
        selectedNote == null ? 'ADD NOTE' : 'EDIT - ${selectedNote.title}';
    GlobalKey<FormState> key = GlobalKey();
    TextEditingController titlecontroller = notesProvider.title;
    TextEditingController contentcontroller = notesProvider.content;
    titlecontroller.text = selectedNote == null ? '' : selectedNote.title!;
    contentcontroller.text = selectedNote == null ? '' : selectedNote.content!;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            title,
            style: appbartitleText,
          ),
          centerTitle: true),
      body: Form(
        key: key,
        child: ListView(
          children: [
            kHeight50,
            TextFieldWidget(
              controller: titlecontroller,
              labelText: 'title',
              validateText: '',
              maxLength: 10,
            ),
            TextFieldWidget(
              controller: contentcontroller,
              labelText: 'Content',
              validateText: 'field not empty',
              maxLines: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(120, 20, 120, 0),
              child: OutlinedButton(
                onPressed:isEdit? () {
                  if (key.currentState!.validate()) {
                   notesProvider.updateNote();
                    Navigator.pop(context);
                  }
                 
                }:() {
                  if (key.currentState!.validate()) {
                   notesProvider.addNotes();
                    Navigator.pop(context);
                  }
                  
                 
                },
                child: Text(
                 isEdit? 'update':'save',
                  style: titleText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
