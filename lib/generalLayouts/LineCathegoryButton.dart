import 'package:flutter/material.dart';

class LineCathegoryButton extends StatelessWidget {
  const LineCathegoryButton({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
     return   Row(
                children: [
                  Expanded(
                    child:SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 5,
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
                              'Education',
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
                    ),
                  ),

                ],
              );
            }
          }