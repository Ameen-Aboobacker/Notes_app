import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import '../view/edit.dart';
import 'alert.dart';
import 'bottom_button.dart';

class BottomButtonBar extends StatelessWidget {
  const BottomButtonBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController notesProvider = context.watch<HomeController>();
    return Container(
      color: Colors.white,
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: [
          BottomButtonWidget(
              name: 'Edit',
              onpressed: () {
                if (notesProvider.selectedNotes.isEmpty ||
                    notesProvider.selectedNotes.length > 1) {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertMessage(
                        message: 'Select exactly one Note for edit'),
                  );
                } else {
                  notesProvider.setSelectedNote();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Edit(),
                  ));
                }
              },
              icon: Icons.edit),
          BottomButtonWidget(
              name: 'Delete',
              onpressed: () {
                if (notesProvider.selectedNotes.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const AlertMessage(message: 'Select atleast one Note'),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('Are you sure to delete?'),
                      title: const Text('Delete'),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                             log(notesProvider.selectedNotes.length.toString());
                            notesProvider.delete();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'YES',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'NO',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icons.delete),
          BottomButtonWidget(
              name: 'Select all',
              onpressed: () {
                notesProvider.allNotes();
              },
              icon: Icons.checklist),
        ],
      ),
    );
  }
}
