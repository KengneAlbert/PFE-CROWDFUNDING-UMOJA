import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardProjetHome extends StatelessWidget{
  
  final String imagePath;
  final String title;
  final String smallTitle;

  const CardProjetHome({

    required this.imagePath,
    required this.title,
    required this.smallTitle,

  });
  
  @override
  Widget build(BuildContext context) {
      return  Row(
                children: [
                  Expanded(
                      child:Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Image.asset(imagePath),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [

                            Text(
                              smallTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF858C94),
                              ),
                            ),

                            SizedBox(width: 5,),
                            
                            SvgPicture.asset(
                              'assets/icons/svg/super.svg',
                              height: 15,
                              width: 15,
                              )

                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Follow',
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
              );
  }
}