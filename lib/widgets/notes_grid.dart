import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/notemodel.dart';

class NoteGrid extends StatelessWidget {
  const NoteGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, notesProvider, _) {
      notesProvider.getNotes();

      return Container(
        child:  notesProvider.notes == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : notesProvider.notes!.isEmpty
              ? const Center(
                  child: Text(
                    'no notes',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    itemCount: notesProvider.notes!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final NoteModel note = notesProvider.notes![index];
                      String time = DateFormat('h:mm a').format(note.datetime!);
                      String date = checkDate(note.datetime!);
                      return GestureDetector(
                        onLongPress: () {
                          notesProvider.selectNote();
                          if (notesProvider.selectedNotes.isEmpty) {
                            notesProvider.setSelectedNotes(note.id!);
                          } else {
                            notesProvider.selectedNotes.clear();
                          }
                          log(notesProvider.selectedNotes.toString());
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kHeight,
                                Text(
                                  note.title ?? '',
                                  style: titleText,
                                ),
                                kHeight,
                                Expanded(
                                  child: Text(
                                    note.content ?? '55',
                                    style: contentText,
                                    maxLines: 10,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(date, style: footerText),
                                        Text(time, style: footerText),
                                      ],
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: notesProvider.isNoteSelected
                                            ? notesProvider.selectedNotes
                                                    .contains(note.id)
                                                ? IconButton(
                                                    icon: const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.black54,
                                                    ),
                                                    onPressed: () {
                                                      notesProvider
                                                          .removeSelectedNotes(
                                                              note.id!);
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: const Icon(
                                                      Icons.circle_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                    onPressed: () {
                                                      notesProvider
                                                          .setSelectedNotes(
                                                              note.id!);
                                                    },
                                                  )
                                            : null,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
      );
    });
  }

  checkDate(DateTime date) {
    String day = DateFormat('EEE,MMMM-dd').format(date);
    if (isYesterday(date)) {
      day = 'Yesterday';
    } else if (isToday(date)) {
      day = 'Today';
    }

    return day;
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isYesterday(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }
}
