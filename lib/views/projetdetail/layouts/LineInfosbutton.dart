import 'package:flutter/material.dart';

class LineInfosbutton extends StatelessWidget {
  
  final String label;

    const LineInfosbutton({
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
                        label,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ), 
                  ),
                  Expanded(
                      child:Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'ViewPlan',
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
                ],
              ),
    );
  }
}