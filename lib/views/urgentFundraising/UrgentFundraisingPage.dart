import 'package:flutter/material.dart';
import '../../generalLayouts/ContainerBottom.dart';
import 'UrgentFundraisingContaint.dart';



class UrgentFundraisingPage extends StatelessWidget{
  const UrgentFundraisingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.green,
          size: 24,
        ),
        title: Text(
          'Urgent Fundraising',
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
      
      body: UrgentFundraisingContaint(),
            
      

      bottomNavigationBar: ContainerBottom(),
      
    );
  }
}