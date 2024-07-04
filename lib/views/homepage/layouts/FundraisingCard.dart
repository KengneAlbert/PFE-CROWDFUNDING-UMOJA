//import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../bookmark/BookmarkPage.dart';

class FundraisingCard extends StatelessWidget {
  final String ImagePath;
  final String Title;
  final String TitleFunding;
  final double ValueFunding;
  final String NumberDonation;

     const FundraisingCard(
        {
          required this.ImagePath,
          required this.Title, 
          required this.TitleFunding, 
          required this.ValueFunding, 
          required this.NumberDonation, 
      }
     );

  @override
  Widget build(BuildContext context) {
    return Card(
                            child: Container(
                                width: 290,
                                height: 260,
                                child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.zero,
                                          bottomRight: Radius.zero,
                                        ),
                                        child:Image.network(
                                          ImagePath,
                                          height: 160,
                                          width: 290,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: 8,
                                          child:GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>   BookmarkPage(),
                                                )
                                              );
                                            },
                                            child:  Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF13B156).withOpacity(1), // Couleur de fond
                                                borderRadius: BorderRadius.circular(12), // Bordure arrondie
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Icon(
                                                  Icons.bookmark_border,
                                                  color: Colors.white,
                                                  size: 25,
                                                  ), 
                                                ),
                                              )
                                            ),
                                          ),
                                      ),
                                    ],
                                  ),
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          Title,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
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
    
                                            Text(
                                              'See all Detail',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
  } 
}      