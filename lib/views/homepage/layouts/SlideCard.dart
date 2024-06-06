import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

class SlideCard extends StatelessWidget{
  const SlideCard({super.key});
  @override
  Widget build(BuildContext context) {
    return    Row(
                children: [
                  Container(
                    width: 380,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AnotherCarousel(
                        indicatorBgPadding: 10.0,
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
              );
  }
} 