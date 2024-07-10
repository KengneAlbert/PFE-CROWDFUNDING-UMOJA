import 'package:flutter/material.dart';

class LineInfos extends StatelessWidget {
  
  final String label;
  final String label2;
  final Widget page;

    const LineInfos({
    required this.label,
    required this.label2,
    required this.page,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  Expanded(
                      child:Align(
                      alignment: Alignment.centerLeft,
                      child:Text(
                          label,
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>   page,
                            )
                          );
                        },
                        child: Text(
                          label2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green
                          ),
                        ),
                      ),
                      
                    ), 
                  ),  
                ],
              );
  }
}