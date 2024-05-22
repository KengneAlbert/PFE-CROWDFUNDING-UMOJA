import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child:Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.green,
                      
                    ),
                    title: Text(
                      '\$349',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      'My wallet balance',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF858C94),
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Top up',
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
                  ),
                ),
              ),

            ],
          ),

          SizedBox(height: 20),
          
          Row(
            children: [
              Container(
                width: 380,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AnotherCarousel(
                    images: [
                       ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/2.jpg',
                           fit: BoxFit.cover,
                        ),
                       ),
                       ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/3.jpg',
                           fit: BoxFit.cover,
                        ),
                       ),
                     
                    ],
                    
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                  child:Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Urgent Fundraising',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),
                ), 
              ),
              Expanded(
                  child:Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green
                    ),
                  ),
                ), 
              ),  
            ],
          ),

          SizedBox(height: 20),

          Row(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal:27, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(
                            color: Colors.green,
                            width: 3,
                          ),
                        )
                      ),
                    ),
                    
                    SizedBox(width: 5),

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

                    SizedBox(width: 5,),

                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Disaster',
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

                    SizedBox(width: 5,),

                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Educ',
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
                    
                  ],
                ),
              )
            ],
          ),
          
        ],
      ),
    );
    
  }
}