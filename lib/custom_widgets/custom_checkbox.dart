import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const CustomCheckbox({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    this.activeColor = const Color(0xFF13B156),
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onChanged(_isChecked);
        });
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: _isChecked ? widget.activeColor : widget.inactiveColor,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: _isChecked ? widget.activeColor : Colors.grey,
          ),
        ),
        child: _isChecked
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16.0,
              )
            : null,
      ),
    );
  }
}