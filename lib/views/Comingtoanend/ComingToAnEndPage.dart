import 'package:flutter/material.dart';
import '../generalLayouts/ContainerBottom.dart';
import 'ComingToAnEndContaint.dart';
import '../homepage/HomePage.dart';



class ComingToAnEndPage extends StatelessWidget{
  const ComingToAnEndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>  HomePage()
                )
              );
            },
          child: Icon(
            Icons.arrow_back,
            color: Colors.green,
            size: 24,
          ),
        ),
        title: Text(
          'Coming to an end',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
               
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF13B156).withOpacity(0.1), // Couleur de fond
                  borderRadius: BorderRadius.circular(12), // Bordure arrondie
                ),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.green,
                  ), 
                ),
              ),
            ),
          )
        ],
      ),
      
      body: ComingToAnEndContaint(),
            
      

      bottomNavigationBar: ContainerBottom(),
      
    );
  }
}