import 'package:flutter/material.dart';

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(
        width: 1,
        color: Colors.black,
      )));
}

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    onPressed: () => onPressed(),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => (Colors.deepPurple)),
      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10)),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Row kLoginOrRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style: const TextStyle(color: Colors.deepPurple)),
        onTap: () => onTap(),
      )
    ],
  );
}

Expanded kLikeAndComment (int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap:() => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size:16, color: color),
              const SizedBox(width: 4,),
              Text('$value'),
            ],
          ),
        ),
      ),
    )
  );
}