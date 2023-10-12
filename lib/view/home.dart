import 'package:flutter/material.dart';
import 'package:notes/constants.dart';
import 'package:notes/provider.dart';
import 'package:notes/view/edit.dart';
import 'package:notes/widgets/button_bar.dart';
import 'package:notes/widgets/notes_grid.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  Future<bool> _onWillPop(BuildContext context, HomeController homectrl) async {
    if (homectrl.isNoteSelected) {
      Provider.of<HomeController>(context, listen: false).selectNote();
      Provider.of<HomeController>(context, listen: false).selectedNotes.clear();
      return false; // Prevent default back navigation
    }
    return true; // Allow default back navigation
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<HomeController>(context); 
    return WillPopScope(
      onWillPop: () => _onWillPop(context, notesProvider),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes', style: TextStyle(color: Colors.green)),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight20,
              Text(
               notesProvider.notes==null?'': '${notesProvider.notes?.length} Note(s)',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              kHeight20,
              const NoteGrid()
            ],
          ),
        ),
        floatingActionButton: notesProvider.isNoteSelected
            ? const BottomButtonBar()
            : FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                       const Edit(isEdit: false,)
                  );
                },
                child: const Icon(Icons.add),
              ),
      ),
    );
  }
}
