import 'package:flutter/material.dart';

class NotifcationPageNotFound extends StatelessWidget{
 const NotifcationPageNotFound({Key? key}) : super(key: key);
        

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Image.asset(
            "assets/images/anynotification.png"
          ),
        ),
      );
  }
}  