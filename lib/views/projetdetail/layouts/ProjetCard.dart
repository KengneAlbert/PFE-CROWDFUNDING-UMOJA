import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';


class ProjetCard extends StatelessWidget {
  final String Title;
  final String TitleFunding;
  final double ValueFunding;
  final String NumberDonation;
  final String Day;
  final String projectId;

     const ProjetCard(
      {
         required this.Title, 
         required this.TitleFunding, 
         required this.ValueFunding, 
         required this.NumberDonation, 
         required this.Day, 
         required this.projectId, 
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
                                        
                                          
                                        SizedBox(height: 8),

                                        Text(
                                          TitleFunding,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),

                                        SizedBox(height: 8),

                                        LinearProgressIndicator(
                                          value: ValueFunding, // Calculate the percentage raised
                                          backgroundColor: Colors.grey[300],
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                        ),

                                        SizedBox(height: 8),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              NumberDonation,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              Day,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 15),
                                        
                                        
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Medical',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                padding: EdgeInsets.symmetric(horizontal:25, vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(100),
                                                  side: BorderSide(
                                                    color: Colors.green,
                                                    width: 3,
                                                  ),
                                                )
                                              ),
                                            ),

                                            SizedBox(width: 1,),

                                            Stack(
                                              children: <Widget>[

                                                ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: Image.asset(
                                                  "assets/images/2.jpg",
                                                  height: 40,
                                                  width: 40,
                                                  fit: BoxFit.cover,
                                                  ),
                                                ),  

                                                Positioned(
                                                  left: -5, // Décale l'image de fond de 20 pixels vers la droite
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Image.asset(
                                                      "assets/images/proje.png", // Remplacez par le chemin de votre image de fond
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  left: -10, // Décale l'image de fond de 20 pixels vers la droite
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Image.asset(
                                                      "assets/images/3.jpg", // Remplacez par le chemin de votre image de fond
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),

                                              ]
                                            ),

                                            
                                            SizedBox(width: 1,),

                                            Text(
                                              "3,438 donators",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                )
                                              ),

                                            SizedBox(width: 10,),

                                            GestureDetector(
                                              onTap: () {
                                               
                                              },
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.green,
                                                ), 
                                              ),
                                            )

                                          ],
                                        ),

                                        SizedBox(height: 20,),

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