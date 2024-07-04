import 'package:flutter/material.dart';

class PayementCard extends StatelessWidget{
  const PayementCard({super.key});
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.green,
                          
                        ),
                        title: Text(
                          'My Wallet (\$349)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
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
      );
  }
}