import "package:flutter/material.dart";


class SelectItems extends StatelessWidget {
  final Widget icon;
  final String title;
  final int value;
  final bool isSelected;
  final void Function(int?)? onChanged;

  const SelectItems({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isSelected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected ? Colors.green : Colors.grey,
          width: 2,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: ListTile(
          leading: icon,
          title: Text(title),
          trailing: Radio<int>(
            activeColor: Colors.green,
            value: value,
            groupValue: isSelected ? value : null,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}g