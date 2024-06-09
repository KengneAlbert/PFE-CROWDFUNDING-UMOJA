import 'package:flutter/material.dart';

class ProjetCard extends StatelessWidget {
  final String Title;
  final String TitleFunding;
  final double ValueFunding;
  final String NumberDonation;
  final String Day;

     const ProjetCard(
      {
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
                                width: 290,
                                height: 300,
                                child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
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