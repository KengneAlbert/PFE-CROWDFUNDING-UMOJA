import 'package:flutter/material.dart';


class ActionButton extends StatelessWidget {
  
  const ActionButton({Key? key}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
                children: [
                  
                  Expanded(
                      child:Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal:50, vertical: 10),
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

                  Expanded(
                      child:Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(

                        onPressed: () {},
                        child: Text(
                            'Remove',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal:50, vertical: 10),
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