//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:umoja/views/bookmark/layouts/ShowBookmark.dart';

class BookmarkFundingCard extends StatelessWidget {
  final String ImagePath;
  final String Title;
  final String TitleFunding;
  final double ValueFunding;
  final String NumberDonation;
  final String Day;

     const BookmarkFundingCard(
      {
         required this.ImagePath,
         required this.Title, 
         required this.TitleFunding, 
         required this.ValueFunding, 
         required this.NumberDonation, 
         required this.Day, 
     }
     );

  @override
  Widget build(BuildContext context) {
    return Card(
                            child: Container(
                                width: 370,
                                height: 300,
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
                                        child:Image.asset(
                                          ImagePath,
                                          height: 160,
                                          width: 370,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: 8,
                                          child:GestureDetector(
                                            onTap: () {
                                              //showModalBottomSheet(context: context, builder: (ctx) => ShowBookmark());
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
                                                  Icons.bookmark,
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

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
  } 
}      