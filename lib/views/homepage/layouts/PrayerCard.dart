import 'package:flutter/material.dart';

class PrayerCard extends StatelessWidget {
  const PrayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:Container(
                      width: 300,
                      height: 210,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/téléchargement (5).png'),
                                    
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Esther Howard', 
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ),
                                      Text(
                                        'Today', 
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          )
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.green,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Hopefully Audrey can get surgery soon, recover from her illness, and play with her friends..',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'You and 48 others sent this prayer',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon
                                  (
                                    Icons.favorite_border,
                                    color: Colors.green,
                                    size: 24.0,
                                  ),

                                  SizedBox(width: 8),
                                  Text(
                                    'Aamiin',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    )
                  ),
                ),

                
                SizedBox(width: 5,),


                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:Container(
                      width: 300,
                      height: 210,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/téléchargement (5).png'),
                                    
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Esther Howard', 
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ),
                                      Text(
                                        'Today', 
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          )
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.green,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Hopefully Audrey can get surgery soon, recover from her illness, and play with her friends..',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'You and 48 others sent this prayer',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon
                                  (
                                    Icons.favorite,
                                    color: Colors.green,
                                    size: 24.0,
                                  ),

                                  SizedBox(width: 8),
                                  Text(
                                    'Aamiin',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    )
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

