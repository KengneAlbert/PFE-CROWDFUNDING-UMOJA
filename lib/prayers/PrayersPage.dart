import 'package:flutter/material.dart';
import 'package:umoja/prayers/PrayersPageContaint.dart';
import 'package:umoja/views/home/page.dart';
import 'package:umoja/views/homepage/HomePage.dart';
import '../generalLayouts/ContainerBottom.dart';



class PrayersPage extends StatelessWidget{
  const PrayersPage({Key? key}) : super(key: key);

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
          'Prayers from Goo...',
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
                    Icons.search,
                    color: Colors.green,
                  ), 
                ),
              ),
            ),
          ),
          
          Padding(

            padding: EdgeInsets.all(5),
            child:  GestureDetector(
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
          ),

        ],
      ),
      
      body: PrayersPageContaint(),
            
      

      bottomNavigationBar: ContainerBottom(),
      
    );
  }
}