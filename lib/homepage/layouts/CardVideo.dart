import 'package:flutter/material.dart';

class CardVideo extends StatelessWidget{
  const CardVideo({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                    width: 177,
                    height: 240,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color(0x2e000000),
                        Color(0x57000000),
                        Color(0x99000000),
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/téléchargement (5).jfif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                SizedBox(width: 20,),


                Container(
                    width: 177,
                    height: 240,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color(0x2e000000),
                        Color(0x57000000),
                        Color(0x99000000),
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/images.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


              ],

            ),
          ),
        ),
      ],
    );
                

    
  
  }
}