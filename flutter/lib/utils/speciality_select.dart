import 'package:flutter/material.dart';

class MySelectWidget extends StatefulWidget {
  @override
  _MySelectWidgetState createState() => _MySelectWidgetState();
}

class _MySelectWidgetState extends State<MySelectWidget> {
  String selectedValue = 'Opção 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
      },
      items: <String>['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}