import 'package:flutter/material.dart';

class CardVideo extends StatelessWidget{
  const CardVideo({super.key});
  @override
  Widget build(BuildContext context) {
    return  Stack(
                  children: [
                    Container(
                      width: 177,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x00000000),
                            Color(0x2e000000),
                            Color(0x57000000),
                            Color(0x99000000),
                          ],
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Group.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Help Improve ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              // Action du bouton
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0),
                                border: Border.all(
                                  color: Colors.green, // Couleur des bordures
                                  width: 5, // Épaisseur des bordures
                                ),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                );
  }
}