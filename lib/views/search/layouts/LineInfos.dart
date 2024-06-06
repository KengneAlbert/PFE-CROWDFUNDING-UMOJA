import 'package:flutter/material.dart';

class LineInfos extends StatelessWidget {
  
  final String label;

    const LineInfos({
    required this.label,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
                children: [
                  Expanded(
                      child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Search Results',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6D7580),
                        ),
                      ),
                    ), 
                  ),
                  Expanded(
                      child:Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        label,
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
    );
  }
}