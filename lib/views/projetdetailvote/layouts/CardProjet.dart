import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardProjet extends StatelessWidget{
  
  final String imagePath;
  final String title;
  final String smallTitle;

  const CardProjet({

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
                        
                      ),
                    ),
                  ),

                ],
              );
  }
}