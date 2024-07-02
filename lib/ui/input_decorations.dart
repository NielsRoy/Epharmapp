import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          //color: Colors.deepPurple,
          color: Color.fromRGBO(4, 120, 87, 1)
        )
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(4, 120, 87, 1),
          width: 2
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixIcon != null 
        ? Icon(prefixIcon, color: const Color.fromRGBO(4, 120, 87, 1))
        : null
    );
  }

}