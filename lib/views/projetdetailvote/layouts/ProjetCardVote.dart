import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';


class ProjetCardVote extends StatelessWidget {
  final String Title;
     const ProjetCardVote(
      {
         required this.Title, 
     }
     );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Container(
                                width: 380,
                                height: 300,
                                child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Container(
                                          height: 50, // Hauteur du conteneur pour le texte défilant
                                          width: double.infinity, // Largeur du conteneur
                                          child: Marquee(
                                            text: Title,
                                            style: TextStyle(
                                              fontSize: 29,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollAxis: Axis.horizontal, // Définit l'axe de défilement
                                            blankSpace: 20.0, // Espace blanc entre les répétitions de texte
                                            velocity: 100.0, // Vitesse de défilement
                                            pauseAfterRound: Duration(seconds: 1), // Pause après chaque passage complet
                                            startPadding: 10.0, // Espace avant le début du texte
                                            accelerationDuration: Duration(seconds: 1), // Durée d'accélération
                                            accelerationCurve: Curves.linear, // Courbe d'accélération
                                            decelerationDuration: Duration(milliseconds: 500), // Durée de décélération
                                            decelerationCurve: Curves.easeOut, // Courbe de décélération
                                          ),
                                        ),
                                        
                                          
                                        SizedBox(height: 15),

                                        

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Wrap(
                                              children: [

                                                 Icon(
                                                  Icons.thumb_up_off_alt,
                                                  color: Colors.green,
                                                  size: 25,
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                  ' 100 likes',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                ),

                                              ],
                                            ),
                                          
                                            
                                          ],
                                        ),

                                        SizedBox(height: 15),
                             
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Donate Now',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding: EdgeInsets.symmetric(horizontal:40, vertical: 6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                                side: BorderSide(
                                                  color: Colors.green,
                                                  width: 3,
                                                ),
                                              )
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
      ),
      );
  } 
}      