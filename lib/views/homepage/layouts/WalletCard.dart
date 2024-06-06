import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget{
  const WalletCard({super.key});
  @override
  Widget build(BuildContext context) {
      return  Row(
                children: [
                  Expanded(
                      child:Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.account_balance_wallet,
                          color: Color(0xFF13B156),
                          
                        ),
                        title: Text(
                          '\$349',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          'My wallet balance',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF858C94),
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Top up',
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