import 'package:flutter/material.dart';
import 'package:umoja/profile/top_up_method_page.dart';

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  int _selectedAmount = 100; // Default amount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green), 
          onPressed: () {
          Navigator.pop(context);
        },
        ),
        title: Text("Top up"),
        actions: [
          Icon(Icons.more_vert, color: Colors.green),
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
                  color: Colors.green,
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
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => TopUpMethodPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: Text("Continue"),
            ),
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
        backgroundColor: _selectedAmount == amount ? Colors.green : Colors.white,
        foregroundColor: _selectedAmount == amount ? Colors.white : Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text("\$$amount"),
    );
  }
}