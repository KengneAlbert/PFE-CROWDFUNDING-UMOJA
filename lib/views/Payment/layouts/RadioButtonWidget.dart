import 'package:flutter/material.dart';

class RadioButtonWidget extends StatefulWidget {
  @override
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  String? _selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return ListTile(
          title: const Text('Option 1'),
          leading: Radio<String>(
            value: 'Option 1',
            groupValue: _selectedValue,
            onChanged: (String? value) {
              setState(() {
                _selectedValue = value;
              });
            }));
  }
}