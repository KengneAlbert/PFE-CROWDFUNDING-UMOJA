import 'package:flutter/material.dart';
import 'layouts/TopUpSuccess.dart';

class NotificationPageContaint extends StatelessWidget{
  const NotificationPageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [

              Container(
                child:Text(
                "Today, December 25 2023",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                 ),
                ),
              ),

              SizedBox(height: 20,),

              TopUpSuccess()

            ],
          ),
        ),
      ),
    );
  }

}