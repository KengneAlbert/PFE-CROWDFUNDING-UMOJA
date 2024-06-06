import 'package:flutter/material.dart';
import '../../generalLayouts/ContainerBottom.dart';
import 'NotifcationPageNotFound.dart';
import 'NotificationPageContaint.dart';

class NotificationPage extends StatelessWidget{
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
            size: 24,
          ),
        ),
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {}, 
            child: Icon(
              Icons.more_vert,
              color: Colors.green,
            ),
          )
        ],
      ),
      
      body:NotificationPageContaint() ,
      //NotifcationPageNotFound(),

      // bottomNavigationBar: ContainerBottom(),
      
    );
  }
}