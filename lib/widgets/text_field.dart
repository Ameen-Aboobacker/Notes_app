import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? validateText;
  final int  maxLength;
  final int  maxLines;
  
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
     this.validateText,
    this.maxLength=1,
    this.maxLines=1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        maxLength:maxLength==1?null:maxLength ,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validateText;
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: labelText),
      ),
    );
  }
}
