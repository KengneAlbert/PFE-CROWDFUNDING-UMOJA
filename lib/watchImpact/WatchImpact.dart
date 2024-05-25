import 'package:flutter/material.dart';
import '../generalLayouts/ContainerBottom.dart';
import 'WatchImpactContaint.dart';
//import 'UrgentFundraisingContaint.dart';



class WatchImpact extends StatelessWidget{
  const WatchImpact({Key? key}) : super(key: key);

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
          'Watch the Impact of Yo',
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
      
      body: WatchImpactContaint(),
            
      

      bottomNavigationBar: ContainerBottom(),
      
    );
  }
}