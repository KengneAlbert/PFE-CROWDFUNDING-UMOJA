import 'package:flutter/material.dart';

class FundingCardSearch extends StatelessWidget{

  final String projectId;
  final String ImagePath;
  final String Title;
  final String MontFunding;
  final String TotalMontFunding;
  final double ValueFunding;
  final String NumberDonation;
  final String Day;

       const FundingCardSearch(
      {
         required this.projectId,
         required this.ImagePath,
         required this.Title, 
         required this.MontFunding,
         required this.TotalMontFunding, 
         required this.ValueFunding, 
         required this.NumberDonation, 
         required this.Day, 
     }
     );

  @override
   Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
          children: [
            Container(
              width: 120,
              height: 131.53846740722656,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.zero,
                ),
                child: Image.network(
                  ImagePath,
                  width: 120,
                  height: 131.53846740722656,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: MontFunding,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "  fund raised from  ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          
                        ),
                         TextSpan(
                          text: TotalMontFunding,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),

                  Container(
                    width: 230,
                    child: LinearProgressIndicator(
                      value: ValueFunding, // Calculate the percentage raised
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  
                  SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.only(
                      right: 14
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: NumberDonation,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green
                                ),
                              ),
                              TextSpan(
                                text: " "
                              ),
                              TextSpan(
                                text: "Donators",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],                          
                          ),
                        ),

                        
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: Day,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                )
                              ),

                              TextSpan(
                                text: " "
                              ),

                              TextSpan(
                                text: "days left",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                   ),
                  )

                ],
              ),
            ),
          ],
        ),
      
    );


   }
}