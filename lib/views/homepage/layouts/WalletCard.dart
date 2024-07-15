import 'package:flutter/material.dart';
import 'package:umoja/models/WalletModel.dart';
import 'package:umoja/services/UserWalletService.dart';
import 'package:umoja/views/profile/top_up_page.dart';


class WalletCard extends StatelessWidget {
  final String userId;

  WalletCard({required this.userId});

  @override
  Widget build(BuildContext context) {
    final userWalletService = UserWalletService();

    return FutureBuilder<WalletModel?>(
      future: userWalletService.getWalletByUserId(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.green,
                    ),
                    title: Text(
                      '\$ 0',
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
                      onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopUpPage()));
                    },
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
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(
                            color: Colors.green,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          WalletModel wallet = snapshot.data!;
          return Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.green,
                    ),
                    title: Text(
                      '\$${wallet.amount}',
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
                      onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopUpPage()));
                    },
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
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(
                            color: Colors.green,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}


