import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/profile/top_up_method_page.dart';
import 'package:umoja/profile/withdraw_method_page.dart';

class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  int _selectedAmount = 300; // Default amount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)), 
          onPressed: () {
          Navigator.pop(context);
        },
        ),
        title: Text("Withdraw"),
        actions: [
          Icon(Icons.more_vert, color: Color(0xFF13B156)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the Amount",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF13B156),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  "\$ $_selectedAmount",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                buildAmountButton(5),
                buildAmountButton(10),
                buildAmountButton(25),
                buildAmountButton(50),
                buildAmountButton(100),
                buildAmountButton(200),
                buildAmountButton(300),
              ],
            ),
            Spacer(),
            CustomBouton(label: "Continue" , onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawMethodPage()));
            },),
           
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildAmountButton(int amount) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAmount = amount;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedAmount == amount ? Color(0xFF13B156) : Colors.white,
        foregroundColor: _selectedAmount == amount ? Colors.white : Color(0xFF13B156),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF13B156), width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text("\$$amount"),
    );
  }
}