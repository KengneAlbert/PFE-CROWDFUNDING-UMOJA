import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umoja/views/donate/TextProvider.dart';

class ButtonContainer extends StatefulWidget {
  @override
  _ButtonContainerState createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  List<bool> isSelected = [false, false, false, false, false, false];
  List<String> buttonTexts = ['\$1000', '\$2000', '\$5000', '\$1500', '\$2500', '\$8000'];
  TextEditingController _controller = TextEditingController();

  void toggleButton(int index, TextProvider textProvider) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
       textProvider.setText(buttonTexts[index]); // Change the text to match the clicked button
    });
  }

  @override
  Widget build(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);
    return Wrap(
      spacing: 10.0, // Espace horizontal entre les boutons
      runSpacing: 10.0, // Espace vertical entre les lignes de boutons
      children: List.generate(isSelected.length, (index) {
        return ElevatedButton(
            onPressed: () {
              toggleButton(index, textProvider);
            },
            child: Text(
              buttonTexts[index],
              style: TextStyle(
                color: isSelected[index] ? Colors.white : Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected[index] ? Colors.green : Colors.white,
              padding: EdgeInsets.only(
                left: 30,
                right:30
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(
                  color: Colors.green,
                  width: 3,
                ),
              ),
            ),
          );
      })
    );
  }
}  