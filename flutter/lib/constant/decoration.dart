import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/text_theme.dart';

InputDecoration kInputDecoration(String label, {TextStyle? style, bool isLabel = true}) {
  return InputDecoration(
      labelText: isLabel ? label : null,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(
        width: 1,
        color: Colors.black,
      )));
}

GestureDetector kTextButton(String label, Function onPressed, {TextStyle? style}) {
  return  GestureDetector(
    onTap: () => onPressed(),
    child: Text(
        label,
        style: style ?? const TextStyle(color: Colors.black)
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

InkWell kButton (int value, IconData icon, Color color, {Function? onTap}) {
  return onTap == null ? InkWell(
    onTap: () => onTap!(),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size:20, color: color),
          const SizedBox(width: 4,),
          Text('$value'),
        ],
      ),
    ),
  ) : InkWell(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size:20, color: color),
          const SizedBox(width: 4,),
          Text('$value'),
        ],
      ),
    ),
  );
}